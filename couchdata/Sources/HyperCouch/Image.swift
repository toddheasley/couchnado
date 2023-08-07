import SwiftUI
import CouchData

extension Image {
    public init(service: URL.Service) {
        self.init(service.name, bundle: .module)
    }
}

#Preview {
    HStack {
        Image(service: .wikipedia)
        Image(service: .apple)
        Image(service: .netflix)
    }
}

private extension URL.Service {
    var name: String {
        switch self {
        case .wikipedia:
            return "Wikipedia"
        case .apple:
            return "AppleTV"
        case .netflix:
            return "Netflix"
        }
    }
}
