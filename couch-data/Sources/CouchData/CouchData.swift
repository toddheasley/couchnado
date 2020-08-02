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
                return URL(string: "https://toddheasley.github.io/couchnado/\(CouchData.path())")!
            case .custom(let url):
                return url
            }
        }
    }
    
    public static func path(name: String? = nil) -> String {
        return "\(!(name ?? "").isEmpty ? name! : "index").tsv"
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
    
    public static func write(videos: [Video], to url: URL) throws {
        guard let table: Table = Table(records: videos) else {
            throw URLError(.zeroByteResource)
        }
        try table.data.write(to: url)
    }
}
