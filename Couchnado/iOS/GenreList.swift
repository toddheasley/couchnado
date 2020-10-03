import SwiftUI
import CouchData

struct GenreList: View {
    let genres: [String]
    @Binding var filter: Video.Filter
    
    @State private var offset: CGPoint = .zero
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            OffsetScrollView(offset: $offset) { safeAreaInsets in
                VStack(alignment: .leading) {
                    GenreView.allGenres(filter: $filter)
                    ForEach(genres) { genre in
                        GenreView(genre: genre, filter: $filter)
                    }
                }
                .padding(.top, 1.0)
                .padding(.horizontal, .padding)
                .padding(.bottom, max(.padding - safeAreaInsets.bottom, 1.0))
            }
            Divider()
                .opacity(offset.y > 1.0 ? 1.0 : 0.0)
        }
    }
}
