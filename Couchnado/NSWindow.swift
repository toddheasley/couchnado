import AppKit

extension NSWindow {
    func toggleSidebar() {
        tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
