import SwiftUI
import CouchData

struct SearchView: View {
    static func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @Binding var filter: Video.Filter
    
    @State private var text: String = ""
    
    @State private var isEditing: Bool = false {
        didSet {
            if !isEditing {
                Self.endEditing()
            } else {
                filter = .none
            }
        }
    }
    
    private func toggle(editing: Bool) {
        withAnimation(editing ? .easeOut(duration: 0.5) : .easeIn(duration: 0.5)) {
            isEditing = editing
        }
    }
    
    private func filterChanged() {
        switch filter {
        case .title(let title):
            text = title
        case .format, .genre:
            toggle(editing: false)
            fallthrough
        default:
            text = ""
        }
    }
    
    private func textChanged() {
        if text.isEmpty {
            switch  filter {
            case .title:
                filter = .none
            default:
                break
            }
        } else {
            filter = .title(text)
        }
    }
    
    // MARK: View
    var body: some View {
        HStack {
            TextField("Search", text: $text, onEditingChanged: { editing in
                toggle(editing: editing)
            })
            .textFieldStyle(SearchTextFieldStyle(text: $text))
            #if !targetEnvironment(macCatalyst)
            if isEditing {
                CancelButton {
                    toggle(editing: false)
                    text = ""
                }
                .transition(.move(edge: .trailing))
            }
            #endif
        }
        .clipped()
        .onChange(of: filter) { filter in
            filterChanged()
        }
        .onChange(of: text) { text in
            textChanged()
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

fileprivate struct SearchTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    
    // MARK: TextFieldStyle
    func _body(configuration: TextField<_Label>) -> some View {
        HStack {
            Image(systemName:"magnifyingglass")
                .foregroundColor(.secondary)
            configuration
                .textFieldStyle(PlainTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
            if !text.isEmpty {
                ClearButton {
                    text = ""
                }
            }
        }
        .padding(.horizontal, .radius)
        .padding(.vertical, 8.0)
        .background(Color.secondary.opacity(0.15))
        .cornerRadius(.radius)
    }
}

fileprivate struct ClearButton: View {
    let action: () -> Void
    
    // MARK: View
    var body: some View {
        Button(action: action) {
            Image(systemName:"xmark.circle.fill")
                .foregroundColor(.secondary)
        }
    }
}

fileprivate struct CancelButton: View {
    let action: () -> Void
    
    // MARK: View
    var body: some View {
        Button(action: action) {
            Text("Cancel")
                .padding(.horizontal, 4.0)
        }
    }
}
