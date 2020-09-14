import Foundation
import Combine

public class CouchData: ObservableObject {
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
    
    @Published public var isReversed: Bool = false {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    public func load(request: Request = .automatic) {
        subscriber?.cancel()
        subscriber = Self.publisher(request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.error = error as? URLError
                case .finished:
                    self.error = nil
                }
            }, receiveValue: { videos in
                self.allVideos = videos
            })
    }

    public init() {
        load()
    }
    
    private var subscriber: AnyCancellable?
    
    private var allVideos: [Video] = [] {
        didSet {
            videos = allVideos.filtered(by: filter).sorted(by: sort, reversed: isReversed)
            genres = allVideos.genres
        }
    }
}

extension CouchData {
    public enum Request {
        case automatic, refresh, custom(URL)
        
        fileprivate var publisher: AnyPublisher<Data, Error> {
            return Future<Data, Error> { completion in
                switch url.scheme {
                case "http", "https":
                    URLSession.shared.dataTask(with: URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10.0)) { data, response, error in
                        guard let data: Data = data else {
                            completion(.failure(error as? URLError ?? URLError(.badServerResponse)))
                            return
                        }
                        completion(.success(data))
                    }.resume()
                case "file":
                    do {
                        let data: Data = try Data(contentsOf: url)
                        completion(.success(data))
                    } catch {
                        completion(.failure(URLError(.cannotDecodeContentData)))
                    }
                default:
                    completion(.failure(URLError(.unsupportedURL)))
                }
            }
            .eraseToAnyPublisher()
        }
        
        private var cachePolicy: URLRequest.CachePolicy {
            switch self {
            case .refresh:
                return .reloadIgnoringLocalAndRemoteCacheData
            default:
                return .useProtocolCachePolicy
            }
        }
        
        private var url: URL {
            switch self {
            case .automatic, .refresh:
                return URL(string: "https://toddheasley.github.io/couchnado/\(FileFormat.tsv.path())")!
            case .custom(let url):
                return url
            }
        }
    }
    
    public static func publisher(_ request: Request = .automatic) -> AnyPublisher<[Video], Error> {
        return request.publisher
            .tryMap { data in
                guard let videos: [Video] = Table(data: data)?.records(Video.self) else {
                    throw URLError(.cannotDecodeContentData)
                }
                return videos
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension CouchData {
    public enum FileFormat: String, CaseIterable, CustomStringConvertible {
        case html, tsv
        
        public static let `default`: Self = .tsv
        
        public var pathExtension: String {
            return rawValue
        }
        
        public func path(name: String? = nil) -> String {
            guard var name: [String] = name?.components(separatedBy: "."), !name[0].isEmpty else {
                return "index.\(pathExtension)"
            }
            if name.count > 1 {
                name = name.dropLast()
            }
            return "\(name.joined(separator: ".")).\(pathExtension)"
        }
        
        // MARK: CustomStringConvertible
        public var description: String {
            switch self {
            case .html:
                return "web page"
            case .tsv:
                return "spreadsheet"
            }
        }
    }
    
    public static func write(videos: [Video], to url: URL, file format: FileFormat = .default) throws {
        guard let table: Table = Table(records: videos) else {
            throw URLError(.zeroByteResource)
        }
        switch format {
        case .html:
            try HTML(table: table, title: url.deletingPathExtension().lastPathComponent).data.write(to: url)
        case .tsv:
            try table.data.write(to: url)
        }
    }
    
    public func write(to url: URL, file format: FileFormat = .default) throws {
        try Self.write(videos: allVideos, to: url, file: format)
    }
}
