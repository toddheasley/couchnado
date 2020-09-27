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
            Group {
                HStack {
                    Text(genre.capitalized)
                        //.font(.callout)
                        .foregroundColor(isSelected ? Color.white.opacity(0.9) : .primary)
                    Spacer()
                }
                .padding(.horizontal, .horizontal)
                .padding(.vertical, 8.0)
                .background(Color.accent(isSelected))
                .cornerRadius(.radius * 0.75)
            }
            .padding(2.0)
            .background(Color.accentBackground)
            .cornerRadius(.radius)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct GenreView_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    static var previews: some View {
        GenreView(genre: "genre", filter: $filter)
            .padding()
    }
}
