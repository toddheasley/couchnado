import SwiftUI
import HyperCouch
import CouchData

struct ServiceImage: View {
    let service: URL.Service
    
    init(_ service: URL.Service) {
        self.service = service
    }
    
    // MARK: View
    var body: some View {
        Image(service: service)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 44.0)
            .help(service.description)
            .previewDisplayName(service.description)
    }
}

#Preview {
    HStack {
        ServiceImage(.wikipedia)
        ServiceImage(.apple)
        ServiceImage(.netflix)
    }
}
