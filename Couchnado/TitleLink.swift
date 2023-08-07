import SwiftUI
import CouchData

struct TitleLink: View {
    let title: Title
    let url: URL?
    
    init(_ title: Title, url: URL? = nil) {
        self.title = title
        self.url = url
    }
    
    init(video: Video) {
        self.init(video.title, url: video.about)
    }
    
    // MARK: View
    var body: some View {
        if let url {
            Link(destination: url) {
                TitleView(title)
            }
            .help(url.service?.description ?? url.absoluteString)
        } else {
            TitleView(title)
        }
    }
}

#Preview {
    TitleLink("The X-Files", url: URL(string: "https://en.wikipedia.org/wiki/The_X-Files_(franchise)"))
}
