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
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(idealHeight: 22.0)
            .help(service.description)
    }
}
