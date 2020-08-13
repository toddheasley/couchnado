import Cocoa

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        set { }
        get { .none}
    }
}
