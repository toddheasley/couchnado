import Foundation
import CouchData

struct Index: CustomStringConvertible {
    let data: CouchData
    
    var name: String {
        return resource.name
    }
    
    @discardableResult func save(_ url: URL) throws -> URL {
        let url: URL = try .base(string: name, relativeTo: url)
        try description.data(using: .utf8)?.write(to: url)
        return url
    }
    
    init(_ data: CouchData, title: String) throws {
        resource = try Resource(URL.base.relativeString)
        guard var description: String = String(data: resource.data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        description.replace(("title", nil), with: title.description)
        description.replace(("image", nil), with: try URL.base(string: "image.png").absoluteString)
        if let genres: String = description.values(for: ("genres[", "]genres")).first {
            description.replace(("genres[", "]genres"), with: data.genres.map { genre in
                return genres.replacing(("genre", nil), with: genre.description.capitalized)
            }.joined())
        }
        if let genres: String = description.values(for: ("genres?", "?genres")).first {
            description.replace(("genres?", "?genres"), with: !data.genres.isEmpty ? genres : "")
        }
        if let formats: String = description.values(for: ("formats[", "]formats")).first {
            description.replace(("formats[", "]formats"), with: Video.Format.allCases.map { format in
                return formats.replacing(("format", nil), with: format.description.capitalized)
            }.joined())
        }
        description.replace(("description", nil), with: data.description)
        if let videos: String = description.values(for: ("videos[", "]videos")).first {
            description.replace(("videos[", "]videos"), with: data.videos.map { video in
                var videos: String = videos
                videos.replace(("video_filter", nil), with: video.filter)
                if let about: String = videos.values(for: ("video_about?", "?video_about")).first {
                    var about: String = about
                    if let url: URL = video.about {
                        about.replace(("video_about", nil), with: url.absoluteString)
                        about.replace(("video_about_description", nil), with: url.service?.description ?? url.host ?? "")
                    } else {
                        about = ""
                    }
                    videos.replace(("video_about?", "?video_about"), with: about)
                }
                videos.replace(("video_title", nil), with: video.title.description)
                videos.replace(("video_subtitle", nil), with: video.subtitle)
                if let watch: String = videos.values(for: ("video_watch?", "?video_watch")).first {
                    var watch: String = watch
                    if let url: URL = video.watch {
                        watch.replace(("video_watch", nil), with: url.absoluteString)
                        watch.replace(("video_watch_description", nil), with: url.service?.description ?? url.host ?? "")
                    } else {
                        watch = "&nbsp;"
                    }
                    videos.replace(("video_watch?", "?video_watch"), with: watch)
                }
                return videos
            }.joined())
        }
        description = description.replacingOccurrences(of: "\n\n", with: "\n")
        self.description = description.trimmingCharacters(in: .whitespacesAndNewlines)
        self.data = data
    }
    
    private let resource: Resource
    
    // MARK: CustomStringConvertible
    let description: String
}
