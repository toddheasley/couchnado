import SwiftUI
#if os(iOS)
import SafariServices
#endif

struct Safari {
    static func open(url: URL) {
        #if os(iOS)
        UIApplication.shared.windows.first?.rootViewController?.present(SFSafariViewController(url: url), animated: true)
        #elseif os(tvOS)
        UIApplication.shared.open(url)
        #endif
    }
}
