import SwiftUI
import CouchData

extension Image {
    public init(service: URL.Service) {
        self.init(service.name, bundle: .module)
    }
}

struct Image_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Image(service: .wikipedia)
            .previewDisplayName(URL.Service.wikipedia.description)
        Image(service: .apple)
            .previewDisplayName(URL.Service.apple.description)
        Image(service: .netflix)
            .previewDisplayName(URL.Service.netflix.description)
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
