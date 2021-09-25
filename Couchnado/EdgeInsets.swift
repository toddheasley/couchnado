import SwiftUI

extension EdgeInsets {
    static var `default`: Self {
#if os(macOS)
        return Self(top: 10.0, leading: 11.0, bottom: 12.0, trailing: 11.0)
#elseif os(tvOS)
        return Self(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0)
#elseif os(iOS)
        return Self(top: 8.0, leading: 9.0, bottom: 10.0, trailing: 9.0)
#endif
    }
}
