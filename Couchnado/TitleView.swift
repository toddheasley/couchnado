import SwiftUI
import CouchData

struct TitleView: View {
    let title: Title
    
    // MARK: View
    var body: some View {
        Text(title.description)
            .truncationMode(.tail)
            .lineLimit(1)
    }
}

struct TitleView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TitleView(title: "The X-Files")
            .padding()
    }
}
