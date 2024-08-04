import SwiftUI

extension Font {
    public static var tableTitle: Self {
#if os(macOS)
        system(size: 15.0, design: .monospaced)
#elseif os(tvOS)
        headline
#else
        system(.subheadline, design: .monospaced)
#endif
    }
    
    public static var tableSubtitle: Self {
#if os(macOS)
        system(size: 12.0, design: .monospaced)
#elseif os(tvOS)
        caption
#else
        system(.caption, design: .monospaced)
#endif
    }
    
    public static var tableDescription: Self { tableSubtitle }
}
