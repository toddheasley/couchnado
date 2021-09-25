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
            .frame(maxHeight: 44.0)
            .help(service.description)
    }
}

struct ServiceImage_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ForEach(URL.Service.allCases) { service in
            ServiceImage(service)
                .padding()
        }
    }
}
