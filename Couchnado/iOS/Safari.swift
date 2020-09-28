import SwiftUI
import SafariServices

struct Safari {
    static func open(url: URL) {
        UIApplication.shared.windows.first?.rootViewController?.present(SFSafariViewController(url: url), animated: true)
    }
}
