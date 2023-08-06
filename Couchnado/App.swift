import SwiftUI
import HyperCouch
import CouchData

@main
struct App: SwiftUI.App {
    static let title: String = "Couchnado"
    
    @State private var data: CouchData = CouchData()
    @State private var options: FileCommands.Options = FileCommands.Options()
    @State private var text: String = ""
    
    // MARK: App
    var body: some Scene {
#if os(tvOS)
        WindowGroup(Self.title) {
            GeometryReader { proxy in
                HStack {
                    FilterView(format: true)
                        .frame(maxWidth: proxy.size.width * 0.33)
                    Divider()
                        .padding()
                    VideoList()
                }
            }
            .environment(data)
            .alert(error: $data.error) {
                data.error = nil
            }
        }
#elseif os(macOS)
        Window(Self.title, id: Self.title) {
            NavigationSplitView(sidebar: {
                FilterView()
                    .frame(minWidth: 128.0, idealWidth: 192.0)
                    .webPage(data, title: App.title, isExporting: $options.isExportingWebPage)
            }, detail: {
                VideoList()
                    .background(Color.tableBackground)
                    .frame(minWidth: 384.0, idealWidth: 512.0, minHeight: 256.0)
                    .toolbar {
                        ToolbarItem(placement: .status) {
                            FormatPicker()
                                .padding(.horizontal)
                        }
                    }
            })
            .searchable(text: $text)
            .onChange(of: text) {
                data.filter = text.isEmpty ? .none : .title(text)
            }
            .environment(data)
            .spreadsheet(data, isExporting: $options.isExportingSpreadsheet)
            .spreadsheet(data, isImporting: $options.isImportingSpreadsheet)
            .alert(error: $data.error) {
                data.error = nil
            }
        }
        .windowToolbarStyle(.unified(showsTitle: false))
        .commands {
            CommandGroup(replacing: .newItem) {
                FileCommands()
                    .environment(options)
                    .environment(data)
            }
            CommandGroup(replacing: .textFormatting) {
                FormatCommands()
                    .environment(data)
            }
            CommandGroup(replacing: .toolbar) {
                ViewCommands()
                    .environment(data)
            }
            SidebarCommands()
            CommandGroup(replacing: .help) {
                HelpCommands()
            }
        }
#elseif os(iOS)
        WindowGroup(Self.title) {
            NavigationStack {
                VideoList()
                    .background(Color.tableBackground)
                    .refreshable {
                        data.load()
                    }
            }
            .searchable(text: $text)
            .onChange(of: text) {
                data.filter = text.isEmpty ? .none : .title(text)
            }
            .environment(data)
            .alert(error: $data.error) {
                data.error = nil
            }
        }
#endif
    }
}

private extension View {
    func alert(error: Binding<URLError?>, action: @escaping () -> Void = {}) -> some View {
        return alert(item: error) { error in
            Alert(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK"), action: action))
        }
    }
}
