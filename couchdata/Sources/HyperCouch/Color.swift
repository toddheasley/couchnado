import SwiftUI

extension Color {
    public static let tableForeground: Self = Self(rgba: RGBA.color)
    public static let tableBackground: Self = Self(rgba: RGBA.background)
    
    public static func tableLink(_ url: URL? = nil) -> Self {
        return url != nil ? Self(rgba: RGBA.link) : tableForeground
    }
    
    public static func tableRow(_ index: Int? = nil) -> Self {
        return (index ?? 0) % 2 == 0 ? Self(rgba: RGBA.alternate) : clear
    }
    
    private init(rgba: RGBA.Pair) {
        self.init(_Color(rgba: rgba))
    }
    
    private init(rgba: RGBA) {
        self.init(_Color(rgba: rgba))
    }
}
#if os(macOS)

private typealias _Color = NSColor

private extension _Color {
    convenience init(rgba: RGBA.Pair) {
        self.init(name: nil) { appearance in
            if appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua {
                return NSColor(rgba: rgba.dark)
            } else {
                return NSColor(rgba: rgba.light)
            }
        }
    }
    
    convenience init(rgba: RGBA) {
        self.init(srgbRed: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
}
#elseif os(tvOS) || os(iOS)

private typealias _Color = UIColor

private extension _Color {
    convenience init(rgba: RGBA.Pair) {
        self.init { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return UIColor(rgba: rgba.dark)
            default:
                return UIColor(rgba: rgba.light)
            }
        }
    }
    
    convenience init(rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
}
#endif
