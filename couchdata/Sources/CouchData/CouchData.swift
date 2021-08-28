import Foundation

public class CouchData: ObservableObject, CustomStringConvertible {
    @Published public private(set) var videos: [Video] = []
    @Published public private(set) var genres: [String] = []
    @Published public var error: URLError?
    
    @Published public var filter: Video.Filter = .none {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    @Published public var sort: Video.Sort = .default {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    @discardableResult public func save(_ url: URL) throws -> URL {
        guard let table: Table = Table(records: videos) else {
            throw URLError(.zeroByteResource)
        }
        try table.data.write(to: url)
        return url
    }
    
    public func load(_ url: URL? = nil) {
        Task.init {
            do {
                let (data, _) = try await URLSession.shared.data(from: url ?? .data)
                guard let videos: [Video] = Table(data: data)?.records(Video.self) else {
                    throw URLError(.cannotDecodeContentData)
                }
                allVideos = videos
            } catch {
                self.error = error as? URLError
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
