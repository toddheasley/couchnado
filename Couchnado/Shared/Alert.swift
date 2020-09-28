import SwiftUI
import CouchData

extension Alert {
    init(error: URLError, action: @escaping () -> Void) {
        self.init(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK"), action: action))
    }
}

extension View {
    func alert(error: Binding<URLError?>, action: @escaping () -> Void = {}) -> some View {
        return alert(item: error) { error in
            Alert(error: error, action: action)
        }
        
    }
}
