import SwiftUI
import CouchData

@main
struct App: SwiftUI.App {
    static let title: String = "Couchnado"
    
    @StateObject var data: CouchData = CouchData()
    
    // MARK: App
    var body: some Scene {
        WindowGroup(Self.title) {
#if os(macOS)
            NavigationView {
                GenreList()
                    .frame(minWidth: 210.0, idealWidth: 320.0)
                    .toolbar {
                        ToolbarItem {
                            SidebarToolbarItem()
                        }
                    }
                VideoList()
                    .frame(minWidth: 540.0, maxWidth: .infinity, minHeight: 360.0, maxHeight: .infinity)
                    .background()
                    .toolbar {
                        ToolbarItemGroup {
                            Spacer()
                            SearchToolbarItem(filter: $data.filter)
                        }
                    }
            }
            .environmentObject(data)
            .alert(error: $data.error) {
                data.error = nil
            }
#elseif os(tvOS)
            GeometryReader { proxy in
                HStack {
                    GenreList()
                        .frame(width: proxy.size.width * 0.33)
                    Divider()
                    VideoList()
                }
            }
            .environmentObject(data)
            .alert(error: $data.error) {
                data.error = nil
            }
#elseif os(iOS)
            ZStack {
                VideoList()
                SearchView(filter: $data.filter)
                    .background()
                //GenreList()
            }
            .environmentObject(data)
            .alert(error: $data.error) {
                data.error = nil
            }
#endif
        }
#if os(macOS)
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
#endif
    }
}
