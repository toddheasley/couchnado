import SwiftUI
import CouchData
import HyperCouch

struct TitleLink: View {
    let video: Video
    
    // MARK: View
    var body: some View {
        if let watch: (url: URL, description: String) = video.watch {
            Link(destination: watch.url) {
                TitleView(title: video.title)
            }
            .help(watch.description)
        } else {
            TitleView(title: video.title)
        }
    }
}
