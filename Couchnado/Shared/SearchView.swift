import SwiftUI
import CouchData

struct SearchView: View {
    @Binding var filter: Video.Filter
    @State private var text: String = ""
    
    @State private var isEditing: Bool = false {
        didSet {
            guard !isEditing else {
                return
            }
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private func toggle(editing: Bool, animated: Bool = true) {
        let duration: TimeInterval = animated ? 0.2 : 0.0
        withAnimation(editing ? .easeOut(duration: duration) : .easeIn(duration: duration)) {
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
        #if os(iOS)
        HStack {
            HStack {
                HStack {
                    Image(systemName:"magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search", text: $text, onEditingChanged: { editing in
                        toggle(editing: editing)
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
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10.0)
            #if !targetEnvironment(macCatalyst)
            if isEditing {
                Button(action: {
                    toggle(editing: false)
                    text = ""
                }, label: {
                    Text("Cancel")
                        .padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0))
                })
                .buttonStyle(BorderlessButtonStyle())
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
        #else
        TextField("Search", text: $text)
            .onChange(of: filter) { filter in
                filterChanged()
            }
            .onChange(of: text) { text in
                textChanged()
            }
        #endif
    }
}

struct SearchView_Previews: PreviewProvider {
    @State private static var filter: Video.Filter = .none
    
    // MARK: PreviewProvider
    static var previews: some View {
        SearchView(filter: $filter)
    }
}

