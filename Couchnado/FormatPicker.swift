import SwiftUI
import CouchData

struct FormatPicker: View {
    @Environment(CouchData.self) private var data: CouchData
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
        .onChange(of: selection) {
            if let format: Video.Format = Video.Format(rawValue: selection) {
                data.filter = .format(format)
            } else {
                switch data.filter {
                case .format:
                    data.filter = .none
                default:
                    break
                }
            }
        }
        .onChange(of: data.filter) {
            switch data.filter {
            case .format(let format):
                selection = format.id
            default:
                selection = ""
            }
        }
    }
}

#Preview {
    FormatPicker()
        .environment(CouchData())
}
