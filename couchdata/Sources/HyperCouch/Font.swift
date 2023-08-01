import SwiftUI

extension Font {
    public static var tableTitle: Self {
#if os(macOS)
        return system(size: 15.0, design: .monospaced)
#elseif os(tvOS)
        return headline
#else
        return system(.subheadline, design: .monospaced)
#endif
    }
    
    public static var tableSubtitle: Self {
#if os(macOS)
        return system(size: 12.0, design: .monospaced)
#elseif os(tvOS)
        return caption
#else
        return system(.caption, design: .monospaced)
#endif
    }
    
    public static var tableDescription: Self {
        return tableSubtitle
    }
}
