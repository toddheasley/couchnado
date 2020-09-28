import SwiftUI
import CouchData

struct GenreView: View {
    static func allGenres(filter: Binding<Video.Filter>) -> Self {
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
                        .foregroundColor(isSelected ? Color.white.opacity(0.9) : .primary)
                        .truncationMode(.tail)
                        .lineLimit(1)
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
    }
}
