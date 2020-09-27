import SwiftUI
import CouchData

struct WideView: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        VStack {
            SearchView(filter: $data.filter)
            FormatPicker(filter: $data.filter)
                .padding(.bottom, 17.0)
            Text("\(data.description)")
        }
    }
}
