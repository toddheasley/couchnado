import SwiftUI
import CouchData

struct SearchView: View {
    @Binding var filter: Video.Filter
    
    @State private var isEditing: Bool = false
    @State private var text: String = ""
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: View
    var body: some View {
        HStack {
            HStack {
                HStack {
                    Image(systemName:"magnifyingglass")
                    .foregroundColor(.secondary)
                    TextField("Search", text: $text, onEditingChanged: { editing in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEditing = editing
                        }
                    })
                    .textFieldStyle(PlainTextFieldStyle())
                    .disableAutocorrection(true)
                    Button(action: {
                        text = ""
                    }, label: {
                        Image(systemName:"xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .opacity(isEditing && !text.isEmpty ? 0.8 : 0.0)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(EdgeInsets(top: 7.0, leading: 10.0, bottom: 7.0, trailing: 10.0))
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10.0)
            #if os(iOS)
            #if !targetEnvironment(macCatalyst)
            if isEditing {
            Button(action: {
                endEditing()
            }, label: {
                Text("Cancel")
                .padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0))
            })
            .buttonStyle(BorderlessButtonStyle())
            .transition(.opacity)
            }
            #endif
            #endif
        }
        .onChange(of: text) { text in
            filter = text.isEmpty ? filter : .title(text)
        }
        .onChange(of: filter) { filter in
            switch filter {
            case .title(let string):
                text = string
            default:
                endEditing()
                text = ""
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchView(filter: $filter)
            .padding(10.0)
    }
}
