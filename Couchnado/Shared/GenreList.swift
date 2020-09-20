import SwiftUI
import CouchData

struct GenreList: View {
    let genres: [String]
    @Binding var filter: Video.Filter
    
    @State private var offset: CGPoint = .zero
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            Divider()
                .opacity(offset.y > 0.0 ? 1.0 : 0.0)
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
        }
    }
}

struct GenreList_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    @State private static var genres: [String] = [
        "genre",
    ]
    
    // MARK: PreviewProvider
    static var previews: some View {
        GenreList(genres: genres, filter: $filter)
    }
}
