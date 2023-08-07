import Foundation

struct Resource {
    let name: String
    let data: Data
    
    @discardableResult func save(_ url: URL) throws -> URL {
        let url: URL = try .base(string: name, relativeTo: url)
        try data.write(to: url)
        return url
    }
    
    init(_ name: String, data: Data) {
        self.name = name
        self.data = data
    }
    
    init(_ name: String) throws {
        guard let url: URL = Bundle.module.url(forResource: name, withExtension: nil) else {
            throw URLError(.badURL)
        }
        let data: Data = try Data(contentsOf: url)
        self.init(name, data: data)
    }
}
