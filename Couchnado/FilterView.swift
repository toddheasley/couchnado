import SwiftUI
import CouchData

struct FilterView: View {
    let format: Bool
    let genre: Bool
    
    init(format: Bool = false, genre: Bool = true) {
        self.format = format
        self.genre = genre
    }
    
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        ScrollView {
            LazyVStack {
                if format {
                    FormatView()
                    ForEach(Video.Format.allCases) { format in
                        FormatView(format)
                    }
                }
                if format, genre {
                    Divider()
                        .padding()
                }
                if genre {
                    GenreView()
                    ForEach(data.genres) { genre in
                        GenreView(genre)
                    }
                }
            }
            .padding(.default)
        }
    }
}

#Preview {
    FilterView()
        .environment(CouchData())
}
