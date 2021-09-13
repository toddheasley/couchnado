import SwiftUI
import CouchData

struct SearchToolbarItem: View {
    @Binding var filter: Video.Filter
    
    // MARK: View
    var body: some View {
        SearchView(filter: $filter)
            .padding(.vertical, 5.0)
            .padding(.horizontal, 10.0)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(6.0)
            .frame(width: 180.0)
    }
}

struct SearchToolbarItem_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchToolbarItem(filter: $filter)
            .padding()
    }
}
