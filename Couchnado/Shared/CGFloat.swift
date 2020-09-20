import SwiftUI

extension CGFloat {
    static let vertical: Self = 5.0
    
    static var horizontal: Self {
        #if targetEnvironment(macCatalyst)
        return 14.0
        #else
        return 10.0
        #endif
    }
    
    static var radius: Self {
        #if targetEnvironment(macCatalyst)
        return 8.0
        #else
        return 10.0
        #endif
    }
}
