import SwiftUI
import Combine
import CouchData

@main
struct CouchnadoApp: App {
    @StateObject private var data: CouchData = CouchData()
    
    // MARK: App
    var body: some Scene {
        return WindowGroup {
            MainView()
                .environmentObject(data)
                .alert(item: $data.error) { error in
                    Alert(error: error) {
                        data.load()
                    }
                }
        }
        .commands(data: data)
    }
}
