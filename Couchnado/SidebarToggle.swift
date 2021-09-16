import SwiftUI

struct SidebarToggle: View {
    private func toggleSidebar() {
        NSApplication.shared.keyWindow?.toggleSidebar()
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleSidebar) {
            Image(systemName: "sidebar.left")
                .help("Toggle Sidebar")
        }
    }
}

struct SidebarToggle_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SidebarToggle()
            .padding()
    }
}
