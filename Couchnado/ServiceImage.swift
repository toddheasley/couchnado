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
    }
}

struct ServiceImage_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ServiceImage(.apple)
            .previewDisplayName(URL.Service.apple.description)
            .padding()
        ServiceImage(.netflix)
            .previewDisplayName(URL.Service.netflix.description)
            .padding()
    }
}
