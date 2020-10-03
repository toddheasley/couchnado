import SwiftUI

extension CGFloat {
    static let padding: Self = 15.0
    
    static var radius: Self {
        #if targetEnvironment(macCatalyst)
        return 8.0
        #else
        return 10.0
        #endif
    }
}
