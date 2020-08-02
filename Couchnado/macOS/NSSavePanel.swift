import Cocoa
import Combine

extension NSSavePanel {
    public func publisher(name: String) -> AnyPublisher<URL?, Never> {
        nameFieldStringValue = name
        return Future<URL?, Never> { completion in
            self.begin { result in
                completion(.success(result == .OK ? self.url : nil))
            }
        }
        .eraseToAnyPublisher()
    }
}
