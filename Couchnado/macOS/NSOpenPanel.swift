import Cocoa
import Combine

extension NSOpenPanel {
    var publisher: AnyPublisher<[URL], Never> {
        return Future<[URL], Never> { completion in
            self.begin { result in
                completion(.success(self.urls))
            }
        }
        .eraseToAnyPublisher()
    }
    
    convenience init(fileTypes: [String], multipleSelection: Bool = false) {
        self.init()
        allowedFileTypes = fileTypes
        allowsMultipleSelection = multipleSelection
        canChooseDirectories = false
        canChooseFiles = true
    }
}
