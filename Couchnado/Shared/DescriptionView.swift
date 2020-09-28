import SwiftUI

struct DescriptionView: View {
    static var size: CGSize {
        return CGSize(width: .zero, height: UIFontMetrics.default.scaledValue(for: 37.0))
    }
    
    let description: String
    
    // MARK: View
    var body: some View {
        Text(description)
            .font(.description)
            .truncationMode(.tail)
            .lineLimit(1)
            .foregroundColor(.secondary)
            .frame(height: Self.size.height)
    }
}

extension Font {
    fileprivate static var description: Self {
        #if targetEnvironment(macCatalyst)
        return subheadline
        #else
        return caption.weight(.semibold)
        #endif
    }
}
