import SwiftUI
import CouchData

struct SearchBar: View {
    @Binding var filter: Video.Filter
    
    // MARK: View
    var body: some View {
        VStack(spacing: 0.0) {
            Divider()
                .padding(.bottom, 9.0)
            SearchView(filter: $filter)
                    .padding(.default)
        }
        .background(Color.keyboard)
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchBar(filter: .constant(.none))
            .padding()
    }
}
