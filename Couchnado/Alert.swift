import SwiftUI
import CouchData

extension Alert {
    init(error: URLError, action: @escaping () -> Void) {
        self.init(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK"), action: action))
    }
}