import Foundation
import Combine

public struct CouchData {
    public enum Request {
        case `default`, refresh, custom(URL)
        
        fileprivate var publisher: AnyPublisher<Data, Error> {
            return Future<Data, Error> { completion in
                switch url.scheme {
                case "http", "https":
                    URLSession.shared.dataTask(with: URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10.0)) { data, response, error in
                        guard let data: Data = data else {
                            completion(.failure(error ?? URLError(.badServerResponse)))
                            return
                        }
                        completion(.success(data))
                    }.resume()
                case "file":
                    do {
                        let data: Data = try Data(contentsOf: url)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                default:
                    completion(.failure(URLError(.unsupportedURL)))
                }
            }
            .eraseToAnyPublisher()
        }
        
        private var cachePolicy: URLRequest.CachePolicy {
            switch self {
            case .default:
                return .returnCacheDataElseLoad
            case .refresh:
                return .reloadIgnoringLocalAndRemoteCacheData
            default:
                return .useProtocolCachePolicy
            }
        }
        
        private var url: URL {
            switch self {
            case .default, .refresh:
                return URL(string: "https://toddheasley.github.io/couchnado/\(FileFormat.tsv.path())")!
            case .custom(let url):
                return url
            }
        }
    }
    
    public enum FileFormat: String, CaseIterable, Identifiable, CustomStringConvertible {
        case html, tsv
        
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
        
        // MARK: Identifiable
        public var id: String {
            return rawValue
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
    
    public static func publisher(_ request: Request = .default) -> AnyPublisher<[Video], Error> {
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
    
    public static func write(videos: [Video], to url: URL, file format: FileFormat = .tsv) throws {
        guard let table: Table = Table(records: videos) else {
            throw URLError(.zeroByteResource)
        }
        switch format {
        case .html:
            let title: String = url.deletingPathExtension().lastPathComponent
            try HTML(table: table, title: title).data.write(to: url)
        case .tsv:
            try table.data.write(to: url)
        }
    }
}
