import SwiftUI

extension Color {
    static var background: Self {
        return Color(UIColor.systemBackground)
    }
    
    static var secondaryBackground: Self {
        return Color(UIColor.secondarySystemBackground)
    }
    
    static var accentBackground: Self {
        return secondary.opacity(0.05)
    }
    
    static var shadow: Self {
        return secondary.opacity(0.2)
    }
    
    static func alternateBackground(_ index: Int = 0) -> Self {
        return (index % 2 == 0) ? Color.secondary.opacity(0.1) : .clear
    }
    
    static func accent(_ selected: Bool) -> Self {
        return selected ? Color.accentColor.opacity(0.7) : clear
    }
}
