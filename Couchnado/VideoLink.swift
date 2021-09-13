import SwiftUI
import CouchData
import HyperCouch

struct VideoLink: View {
    let video: Video
    
    // MARK: View
    var body: some View {
        Link(destination: video.watch?.url ?? .void) {
            HStack {
                VStack(alignment: .leading) {
                    TitleView(title: video.title)
                    SubtitleView(video.subtitle)
                }
                Spacer()
                // TODO: Add watch URL service icon
            }
        }
        .help(video.watch?.description ?? "")
        #if os(tvOS)
        .opacity(video.watch != nil ? 1.0 : 0.25)
        #else
        .disabled(video.watch == nil)
        #endif
    }
}

private extension URL {
    static let void: Self = Self(string: "#")!
}
