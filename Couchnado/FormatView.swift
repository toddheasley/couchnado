import SwiftUI
import CouchData

struct FormatView: View {
    let format: Video.Format?
    
    var isSelected: Bool {
        switch data.filter {
        case .format(let format):
            return format == self.format
        default:
            return format == nil
        }
    }
    
    init(_ format: Video.Format? = nil) {
        self.format = format
    }
    
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button(action: {
            data.filter = (!isSelected && format != nil) ? .format(format!) : .none
        }) {
            HStack(alignment: .center) {
                Text((format?.description ?? .allFormats).capitalized)
                    .truncationMode(.tail)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(isSelected ? 1.0 : 0.0)
            }
        }
    }
}
    

struct FormatView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        FormatView(.miniseries)
            .environment(CouchData())
            .padding()
        FormatView()
            .environment(CouchData())
            .previewDisplayName("Format View (All)")
            .padding()
    }
}

private extension String {
    static let allFormats: String = "all formats"
}
