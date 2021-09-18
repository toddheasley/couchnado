import SwiftUI
import CouchData
import HyperCouch

struct VideoView: View {
    let video: Video
    
    // MARK: View
    var body: some View {
#if os(tvOS)
        VideoLink(video: video)
#else
        HStack {
            VStack(alignment: .leading) {
                TitleLink(video: video)
                SubtitleView(video.subtitle)
            }
            Spacer()
            if let url: URL = video.watch {
                Link(destination: url) {
                    ServiceImage(service: url.service!)
                }
                .help(url.service!.description)
            }
        }
#endif
    }
}
