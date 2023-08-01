import SwiftUI

extension Color {
    public static let tableForeground: Self = Self(rgb: RGB.color)
    public static let tableBackground: Self = Self(rgb: RGB.background)
    
    public static func tableLink(_ url: URL? = nil) -> Self {
        return url != nil ? Self(rgb: RGB.link) : tableForeground
    }
    
    public static func tableRow(_ index: Int? = nil) -> Self {
        return (index ?? 0) % 2 == 0 ? Self(rgb: RGB.alternate) : clear
    }
    
    private init(rgb: RGB.Pair) {
        self.init(_Color(rgb: rgb))
    }
    
    private init(rgb: RGB) {
        self.init(_Color(rgb: rgb))
    }
}
#if os(macOS)

private typealias _Color = NSColor

private extension _Color {
    convenience init(rgb: RGB.Pair) {
        self.init(name: nil) { appearance in
            if appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua {
                return NSColor(rgb: rgb.dark)
            } else {
                return NSColor(rgb: rgb.light)
            }
        }
    }
    
    convenience init(rgb: RGB) {
        self.init(srgbRed: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }
}
#elseif os(tvOS) || os(iOS)

private typealias _Color = UIColor

private extension _Color {
    convenience init(rgb: RGB.Pair) {
        self.init { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return UIColor(rgb: rgb.dark)
            default:
                return UIColor(rgb: rgb.light)
            }
        }
    }
    
    convenience init(rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }
}
#endif
