import SwiftUI
import CouchData

struct FormatPicker: View {
    @Binding var filter: Video.Filter
    
    @State private var selection: String = ""
    
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
        .onChange(of: selection) { selection in
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
        .onChange(of: filter) { filter in
            switch filter {
            case .format(let format):
                selection = format.id
            default:
                selection = ""
            }
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
