import SwiftUI
import CouchData
import HyperCouch

struct ServiceImage: View {
    let service: URL.Service
    
    // MARK: View
    var body: some View {
        Image(service: service)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: .height)
            .help(service.description)
    }
}

private extension CGFloat {
    static var height: Self {
#if os(tvOS)
        return 41.0
#else
        return 19.0
#endif
        
    }
}
