import SwiftUI
import HyperCouch
import CouchData

struct TitleView: View {
    let title: Title
    
    init(_ title: Title) {
        self.title = title
    }
    
    // MARK: View
    var body: some View {
        Text(title.description)
            .font(.tableTitle)
            .truncationMode(.tail)
            .lineLimit(1)
    }
}

#Preview {
    TitleView("The X-Files")
}
