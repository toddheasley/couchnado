import SwiftUI
import CouchData

struct GenreView: View {
    static func allGenres(filter: Binding<Video.Filter>) -> GenreView {
        return Self(genre: Self.allGenres, filter: filter)
    }
    
    let genre: String
    @Binding var filter: Video.Filter
    
    var isSelected: Bool {
        switch filter {
        case .genre(let genre):
            return genre == self.genre
        default:
            return genre == Self.allGenres
        }
    }
    
    private static let allGenres: String = "all genres"
    
    // MARK: View
    var body: some View {
        Button(action: {
            filter = (!isSelected && genre != Self.allGenres) ? .genre(genre) : .none
        }, label: {
            HStack {
                Text(genre.capitalized)
                    .font(.callout)
                    .fontWeight(isSelected ? .medium : .regular)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
            }
            .padding(EdgeInsets(top: 8.0, leading: 14.0, bottom: 8.0, trailing: 14.0))
            .background(isSelected ? Color.accentColor.opacity(0.8) : Color.secondary.opacity(0.05))
            .cornerRadius(.radius)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct GenreView_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    static var previews: some View {
        GenreView(genre: "genre", filter: $filter)
    }
}
