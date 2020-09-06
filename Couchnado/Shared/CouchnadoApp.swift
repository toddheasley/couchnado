import SwiftUI
import Combine
import CouchData

@main
struct CouchnadoApp: App {
    @StateObject private var data: CouchData = CouchData()
    
    // MARK: App
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(data)
        }
    }
}
