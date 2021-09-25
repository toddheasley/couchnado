import SwiftUI
import CouchData

extension View {
    func alert(error: Binding<URLError?>, action: @escaping () -> Void = {}) -> some View {
        return alert(item: error) { error in
            Alert(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK"), action: action))
        }
    }
}
