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
    
    init(_ genre: String, filter: Binding<Video.Filter>) {
        self.genre = genre
        _filter = filter
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
#if os(macOS)
        .buttonStyle(GenreButtonStyle(isSelected: isSelected))
#endif
    }
}
#if os(macOS)

private struct GenreButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    // MARK: ButtonStyle
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(.secondary)
            .padding(.horizontal, EdgeInsets.default.leading)
            .padding(.vertical, 7.0)
            .background(Color.secondary.opacity(isSelected ? 0.1 : 0.05))
            .cornerRadius(6.5)
    }
}
#endif

extension String {
    static let allGenres: String = "all genres"
}

struct GenreView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        GenreView(.allGenres, filter: .constant(.none))
            .padding()
        GenreView("high school", filter: .constant(.genre("high school")))
            .padding()
        GenreView("high school", filter: .constant(.none))
            .padding()
    }
}
