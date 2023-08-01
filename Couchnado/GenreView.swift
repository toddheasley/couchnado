import SwiftUI
import CouchData

struct GenreView: View {
    let genre: String
    
    var isSelected: Bool {
        switch data.filter {
        case .genre(let genre):
            return genre == self.genre
        default:
            return genre == .allGenres
        }
    }
    
    init(_ genre: String = .allGenres) {
        self.genre = genre
    }
    
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button(action: {
            data.filter = (!isSelected && genre != .allGenres) ? .genre(genre) : .none
        }) {
            HStack(alignment: .center) {
                Text(genre.capitalized)
                    .truncationMode(.tail)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(isSelected ? 1.0 : 0.0)
            }
        }
    }
}

struct GenreView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        GenreView("high school")
            .environment(CouchData())
            .padding()
        GenreView(.allGenres)
            .environment(CouchData())
            .previewDisplayName("Genre View (All)")
            .padding()
    }
}

private extension String {
    static let allGenres: String = "all genres"
}
