import SwiftUI

@Observable public class CouchData: CustomStringConvertible {
    public private(set) var videos: [Video] = []
    public private(set) var genres: [String] = []
    public var error: URLError?
    
    public var filter: Video.Filter = .none {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    public var sort: Video.Sort = .default {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    public var isEmpty: Bool {
        return allVideos.isEmpty
    }
    
    public func load(_ url: URL? = nil) {
        let url: URL = url ?? .data
        Task {
            do {
                switch url.scheme {
                case "file":
                    guard url.startAccessingSecurityScopedResource() else {
                        throw URLError(.noPermissionsToReadFile)
                    }
                    let data: Data = try Data(contentsOf: url)
                    try load(data: data)
                    url.stopAccessingSecurityScopedResource()
                default:
                    let (data, _) = try await URLSession.shared.data(from: url)
                    try load(data: data)
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error as? URLError
                }
            }
        }
    }
    
    public init(_ url: URL? = nil) {
        load(url)
    }
    
    private var allVideos: [Video] = [] {
        didSet {
            videos = allVideos.filtered(by: filter).sorted(by: sort)
            genres = allVideos.genres
        }
    }
    
    private func load(data: Data) throws {
        guard let allVideos: [Video] = Table(data: data)?.records(Video.self) else {
            throw URLError(.cannotDecodeContentData)
        }
        DispatchQueue.main.async {
            self.allVideos = allVideos
        }
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        switch filter {
        case .title, .genre, .format:
            return ["\(videos.count) of \(allVideos.count) videos", "\(filter)"].joined(separator: " ")
        case .none:
            return "\(videos.count) videos"
        }
    }
}
#if os(macOS)

import UniformTypeIdentifiers

extension CouchData: Portable {
    
    // MARK: Portable
    public static let contentType: UTType = Spreadsheet.readableContentTypes.first!
    public static let defaultFilename: String? = URL.data.deletingPathExtension().relativeString
    
    public var file: FileDocument? {
        return Spreadsheet(Table(records: allVideos))
    }
}
#endif
