import SwiftUI

struct DragIndicator: View {
    enum Orientation: String {
        case horizontal, vertical
        
        fileprivate var size: CGSize {
            switch self {
            case .horizontal:
                return CGSize(width: 36.0, height: 5.0)
            case .vertical:
                return CGSize(width: 5.0, height: 36.0)
            }
        }
        
        fileprivate var radius: CGFloat {
            return 2.5
        }
    }
    
    let orientation: Orientation
    
    // MARK: View
    var body: some View {
        RoundedRectangle(cornerRadius: orientation.radius)
            .frame(width: orientation.size.width, height: orientation.size.height)
            .foregroundColor(Color.secondary.opacity(0.5))
    }
}

struct DragIndicator_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HStack {
            DragIndicator(orientation: .horizontal)
                .padding()
            DragIndicator(orientation: .vertical)
                .padding()
        }
    }
}
