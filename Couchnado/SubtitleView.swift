import SwiftUI

struct SubtitleView: View {
    let subtitle: String
    
    init(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    // MARK: View
    var body: some View {
        Text(subtitle)
            .foregroundColor(.primary.opacity(0.75))
            .truncationMode(.tail)
            .lineLimit(1)
    }
}

struct SubtitleView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SubtitleView("1993-2002, 2016-2018 series")
            .padding()
    }
}
