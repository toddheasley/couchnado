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
            // TODO: Add watch URL service link
        }
#endif
    }
}
