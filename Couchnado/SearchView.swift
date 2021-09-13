import SwiftUI
import CouchData

struct SearchView: View {
    @Binding var filter: Video.Filter
    
    @State private var text: String = ""
    
    @State private var isEditing: Bool = false {
        didSet {
            // TODO: End editing
        }
    }
    
    // MARK: View
    var body: some View {
        TextField("Search titles", text: $text) { isEditing in
            self.isEditing = isEditing
        }
        .textFieldStyle(SearchTextFieldStyle(text: $text))
        .onChange(of: text) { text in
            filter = !text.isEmpty ? .title(text) : .none
        }
        .onChange(of: filter) { filter in
            switch filter {
            case .title(let text):
                self.text = text
            case .format, .genre:
                isEditing = false
                fallthrough
            case .none:
                text = ""
            }
        }
    }
}

private struct SearchTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    
    // MARK: TextFieldStyle
    func _body(configuration: TextField<_Label>) -> some View {
        HStack {
            Image(systemName:"magnifyingglass")
                .imageScale(.large)
                .foregroundColor(.secondary)
            configuration
                .textFieldStyle(PlainTextFieldStyle())
                .disableAutocorrection(true)
#if os(iOS)
                .keyboardType(.asciiCapable)
#endif
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName:"xmark.circle.fill")
                        .foregroundColor(.secondary.opacity(0.5))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchView(filter: $filter)
            .padding()
    }
}
