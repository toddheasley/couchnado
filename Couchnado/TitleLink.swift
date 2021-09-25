import SwiftUI
import HyperCouch
import CouchData

struct TitleLink: View {
    let video: Video
    
    // MARK: View
    var body: some View {
        if let url: URL = video.about {
            Link(destination: url) {
                TitleView(video.title)
            }
            .help(url.service!.description)
        } else {
            TitleView(video.title)
        }
    }
}
