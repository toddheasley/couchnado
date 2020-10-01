import SwiftUI
import CouchData

struct GenreList: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack {
                    FormatPicker(size: proxy.size, filter: $data.filter)
                    ForEach(data.genres) { genre in
                        GenreView(genre: genre, size: proxy.size, filter: $data.filter)
                    }
                    VStack {
                    Divider()
                        .padding(.horizontal, proxy.safeAreaInsets.leading)
                        .padding(.vertical, 11.0)
                    Button(action: {}, label: {
                        Text("Choose app icon...")
                    })
                    }
                }
            }
        }
    }
}
