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
                .frame(maxWidth: 420.0)
                .padding(.default)
        }
        .background(Color.keyboard)
    }
}

private extension Color {
    static let keyboard: Self = Self(white: 0.52).opacity(0.327)
}

struct SearchBar_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchBar(filter: .constant(.none))
            .padding()
    }
}
