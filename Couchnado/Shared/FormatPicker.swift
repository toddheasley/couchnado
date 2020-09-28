import SwiftUI
import CouchData

struct FormatPicker: View {
    let size: CGSize?
    @Binding var filter: Video.Filter
    
    init(size: CGSize? = nil, filter: Binding<Video.Filter>) {
        self.size = size != nil ? CGSize(width: size!.width * 0.84, height: size!.height) : nil
        self._filter = filter
    }
    
    @State private var selection: String = ""
    
    private func selectionChanged() {
        if let format: Video.Format = Video.Format(rawValue: selection) {
            filter = .format(format)
        } else {
            switch filter {
            case .format:
                filter = .none
            default:
                break
            }
        }
    }
    
    private func filterChanged() {
        switch filter {
        case .format(let format):
            selection = format.id
        default:
            selection = ""
        }
    }
    
    // MARK: View
    var body: some View {
        Picker("", selection: $selection) {
            Text("All")
                .tag("")
            ForEach(Video.Format.allCases) { format in
                Text(format.description.capitalized)
                    .tag(format.id)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: size?.width)
        .onChange(of: selection) { selection in
            selectionChanged()
        }
        .onChange(of: filter) { filter in
            filterChanged()
        }
    }
}

struct FormatPicker_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    // MARK: PreviewProvider
    static var previews: some View {
        FormatPicker(filter: $filter)
            .padding()
    }
}
