import SwiftUI
import CouchData

struct SearchBar: View {
    @Binding var filter: Video.Filter
    
    // MARK: View
    var body: some View {
        VStack(spacing: 0.0) {
            Divider()
            SearchView(filter: $filter)
                .padding(.default)
        }
        .background(Color.gray.opacity(0.2))
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchBar(filter: .constant(.none))
            .padding()
    }
}
