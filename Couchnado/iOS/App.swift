import SwiftUI
import CouchData

@main
struct App: SwiftUI.App {
    @StateObject private var data: CouchData = CouchData()
    
    // MARK: App
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
                .alert(error: $data.error) {
                    data.load()
                }
        }
        .commands(data: data)
    }
}
