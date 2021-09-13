import SwiftUI
import CouchData

struct GenreView: View {
    let genre: String
    @Binding var filter: Video.Filter
    
    var isSelected: Bool {
        switch filter {
        case .genre(let genre):
            return genre == self.genre
        default:
            return genre == .allGenres
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: {
            filter = (!isSelected && genre != .allGenres) ? .genre(genre) : .none
        }, label: {
            HStack(alignment: .center) {
                Text(genre.capitalized)
                    .truncationMode(.tail)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(isSelected ? 1.0 : 0.0)
            }
        })
    }
}

extension String {
    static let allGenres: String = "all genres"
}

struct GenreView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        GenreView(genre: .allGenres, filter: .constant(.none))
            .padding()
        GenreView(genre: "high school", filter: .constant(.genre("high school")))
            .padding()
        GenreView(genre: "high school", filter: .constant(.none))
            .padding()
    }
}
