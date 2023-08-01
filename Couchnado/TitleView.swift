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

struct TitleView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TitleView("The X-Files")
            .padding()
    }
}
