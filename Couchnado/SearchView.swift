import SwiftUI
import CouchData

struct SearchView: View {
    @Binding var filter: Video.Filter
    
    @State private var text: String = ""
    
    // MARK: View
    var body: some View {
        TextField("Search Titles", text: $text)
            .textFieldStyle(SearchTextFieldStyle(text: $text))
            .onChange(of: text) { text in
                if !text.isEmpty {
                    filter = .title(text)
                } else {
                    switch filter {
                    case .title:
                        filter = .none
                    default:
                        break
                    }
                }
            }
            .onChange(of: filter) { filter in
                switch filter {
                case .title(let text):
                    self.text = text
                default:
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
                        .foregroundColor(.secondary.opacity(0.75))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
#if os(macOS)
        .padding(EdgeInsets(top: 5.0, leading: 9.0, bottom: 6.0, trailing: 9.0))
        .cornerRadius(6.5)
        .overlay(
            RoundedRectangle(cornerRadius: 6.0)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.secondary.opacity(0.1))
        )
#elseif os(iOS)
        .padding(EdgeInsets(top: 7.0, leading: 6.0, bottom: 7.0, trailing: 6.0))
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(10.5)
#endif
    }
}

struct SearchView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchView(filter: .constant(.none))
            .padding()
    }
}
