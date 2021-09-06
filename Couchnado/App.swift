import SwiftUI
import CouchData

@main
struct App: SwiftUI.App {
    static let title: String = "Couchnado"
    
    @StateObject var data: CouchData = CouchData()
    
    // MARK: App
    var body: some Scene {
#if os(macOS)
        WindowGroup(Self.title) {
            ContentView()
                .environmentObject(data)
                .alert(error: $data.error) {
                    data.error = nil
                }
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
                FileCommands()
                    .environmentObject(data)
            }
            CommandGroup(replacing: .textFormatting) {
                FormatCommands()
                    .environmentObject(data)
            }
            CommandGroup(replacing: .toolbar) {
                ViewCommands()
                    .environmentObject(data)
            }
            SidebarCommands()
            CommandGroup(replacing: .help) {
                HelpCommands()
            }
        }
#elseif os(tvOS)
        WindowGroup(Self.title) {
            ContentView()
                .environmentObject(data)
                .alert(error: $data.error) {
                    data.error = nil
                }
        }
#elseif os(iOS)
        WindowGroup(Self.title) {
            ContentView()
                .environmentObject(data)
                .alert(error: $data.error) {
                    data.error = nil
                }
        }
#endif
    }
}
