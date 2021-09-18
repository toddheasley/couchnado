import SwiftUI
import CouchData
import HyperCouch

struct TitleLink: View {
    let video: Video
    
    // MARK: View
    var body: some View {
        if let url: URL = video.watch {
            Link(destination: url) {
                TitleView(title: video.title)
            }
            .help(url.service!.description)
        } else {
            TitleView(title: video.title)
        }
    }
}
