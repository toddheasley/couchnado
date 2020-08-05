import Cocoa
import Combine

extension NSSavePanel {
    public func publisher(nameField value: String) -> AnyPublisher<URL?, Never> {
        cancel(nil)
        nameFieldStringValue = value
        return Future<URL?, Never> { completion in
            self.begin { result in
                completion(.success(result == .OK ? self.url : nil))
            }
        }
        .eraseToAnyPublisher()
    }
}
