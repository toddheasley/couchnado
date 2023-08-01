import SwiftUI
import CouchData

@main
struct App: SwiftUI.App {
    static let title: String = "Couchnado"
    
    @State private var data: CouchData = CouchData()
    @State private var text: String = ""
    
    // MARK: App
    var body: some Scene {
        WindowGroup(Self.title) {
            NavigationSplitView(sidebar: {
                /*
                GenreList()
                    .listStyle(.sidebar)
                    .frame(minWidth: 210.0, idealWidth: 320.0) */
            }, detail: {
                /* VideoList() */
            })
            .environment(data)
        }
        /*.commands {
            SidebarCommands()
        } */
    }
}

/*
    // MARK: App
    var body: some Scene {
#if os(macOS)
        WindowGroup(Self.title) {
            NavigationView {
                GenreList()
                    .frame(minWidth: 210.0, idealWidth: 320.0)
                    .toolbar {
                        SidebarToggle()
                    }
                VideoList()
                    .frame(minWidth: 540.0, maxWidth: .infinity, minHeight: 360.0, maxHeight: .infinity)
                    .toolbar {
                        Spacer()
                        Spacer()
                        FormatPicker(filter: $data.filter)
                        Spacer()
                        SearchView(filter: $data.filter)
                            .frame(width: 140.0)
                    }
            }
            .environmentObject(data)
            .alert(error: $data.error) {
                data.error = nil
            }
        WindowGroup {
            ContentView()
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .commands {
            CommandGroup(replacing: .newItem) {
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
            GeometryReader { proxy in
                HStack {
                    GenreList()
                        .frame(width: proxy.size.width * 0.35)
                    Divider()
                    VideoList()
                }
            }
            .environmentObject(data)
            .alert(error: $data.error) {
                data.error = nil
            }
        }
#elseif os(iOS)
        WindowGroup(Self.title) {
            VStack(spacing: 0.0) {
                VideoList()
                SearchBar(filter: $data.filter)
            }
            .environmentObject(data)
            .alert(error: $data.error) {
                data.error = nil
            }
        }
#endif
    }
} */
