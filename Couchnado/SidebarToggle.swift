import SwiftUI

struct SidebarToggle: View {
    
    // MARK: View
    var body: some View {
        Button(action: {
            NSApplication.shared.keyWindow?.toggleSidebar()
        }) {
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
