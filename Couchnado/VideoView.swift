import SwiftUI
import HyperCouch
import CouchData

struct VideoView: View {
    let video: Video
    let index: Int?
    
    init(_ video: Video, index: Int? = nil) {
        self.video = video
        self.index = index
    }
    
    // MARK: View
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TitleLink(video: video)
                SubtitleView(video.subtitle)
            }
            Spacer()
            if let url: URL = video.watch {
                Link(destination: url) {
                    ServiceImage(url.service!)
                        .frame(height: 19.0)
                }
                .foregroundColor(.primary.opacity(0.35))
                .help(url.service!.description)
            }
        }
        .background(Color.alternate(index))
        .cornerRadius(5.0)
    }
}
