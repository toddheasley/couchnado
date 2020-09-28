import SwiftUI
import CouchData

struct GenreList: View {
    let genres: [String]
    @Binding var filter: Video.Filter
    
    @State private var offset: CGPoint = .zero
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            OffsetScrollView(offset: $offset) {
                VStack(alignment: .leading) {
                    GenreView.allGenres(filter: $filter)
                    ForEach(genres) { genre in
                        GenreView(genre: genre, filter: $filter)
                    }
                }
                .padding(.horizontal, .horizontal)
                .padding(.vertical, .vertical)
            }
            Divider()
                .opacity(offset.y > 0.0 ? 1.0 : 0.0)
        }
    }
}
