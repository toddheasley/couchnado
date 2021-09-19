import SwiftUI

extension Color {
    static var foreground: Self {
        return Self("ForegroundColor")
    }
    
    static var alternate: Self {
        return Self("AlternateColor")
    }
    
    static func alternate(_ index: Int?) -> Self {
        return (index ?? -1) % 2 == 0 ? alternate : clear
    }
}
