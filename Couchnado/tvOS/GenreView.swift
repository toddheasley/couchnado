import SwiftUI
import CouchData

struct GenreView: View {
    let genre: String
    let size: CGSize?
    @Binding var filter: Video.Filter
    
    var isSelected: Bool {
        switch filter {
        case .genre(let genre):
            return genre == self.genre
        default:
            return false
        }
    }
    
    init(genre: String, size: CGSize? = nil, filter: Binding<Video.Filter>) {
        self.genre = genre
        self.size = size != nil ? CGSize(width: size!.width * 0.75, height: size!.height) : nil
        self._filter = filter
    }
    
    // MARK: View
    var body: some View {
        Button(action: {
            filter = !isSelected  ? .genre(genre) : .none
        }, label: {
            HStack {
                Text(genre.capitalized)
                    .truncationMode(.tail)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(isSelected ? 1.0 : 0.0)
            }
            .frame(width: size?.width)
        })
    }
}
