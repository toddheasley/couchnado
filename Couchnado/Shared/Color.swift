import SwiftUI

extension Color {
    static var background: Self {
        return Color(UIColor.systemBackground)
    }
    
    static var secondaryBackground: Self {
        return Color(UIColor.secondarySystemBackground)
    }
    
    static var shadow: Self {
        return Color.secondary.opacity(0.2)
    }
}
