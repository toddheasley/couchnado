import SwiftUI

struct DragIndicator: View {
    enum Orientation: String {
        case horizontal, vertical
        
        fileprivate var size: CGSize {
            switch self {
            case .horizontal:
                return CGSize(width: 36.0, height: .vertical)
            case .vertical:
                return CGSize(width: .vertical, height: 36.0)
            }
        }
        
        fileprivate var radius: CGFloat {
            return .vertical * 0.5
        }
    }
    
    let orientation: Orientation
    
    // MARK: View
    var body: some View {
        RoundedRectangle(cornerRadius: orientation.radius)
            .frame(width: orientation.size.width, height: orientation.size.height)
            .foregroundColor(Color.secondary.opacity(0.5))
            .allowsHitTesting(false)
    }
}
