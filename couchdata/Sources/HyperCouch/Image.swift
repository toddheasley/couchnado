import SwiftUI
import CouchData

extension Image {
    public init(service: URL.Service) {
        let resource: Resource = try! Resource(service.name)
#if os(macOS)
        self.init(nsImage: NSImage(data: resource.data)!)
#elseif os(tvOS) || os(iOS)
        self.init(uiImage: UIImage(data: resource.data)!)
#endif
    }
}
