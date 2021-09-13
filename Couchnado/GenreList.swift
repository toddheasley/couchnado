import SwiftUI
import CouchData

struct GenreList: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        ScrollView {
            LazyVStack {
                GenreView(genre: .allGenres, filter: $data.filter)
                ForEach(data.genres) { genre in
                    GenreView(genre: genre, filter: $data.filter)
                }
            }
            .padding(.default)
        }
    }
}

struct GenreList_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        GenreList()
            .environmentObject(CouchData())
            .padding()
    }
}
