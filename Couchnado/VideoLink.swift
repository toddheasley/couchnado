import SwiftUI
import CouchData
import HyperCouch

struct VideoLink: View {
    let video: Video
    
    // MARK: View
    var body: some View {
        Link(destination: video.watch ?? .void) {
            HStack {
                VStack(alignment: .leading) {
                    TitleView(title: video.title)
                    SubtitleView(video.subtitle)
                }
                Spacer()
                if let service: URL.Service = video.watch?.service {
                    ServiceImage(service: service)
                        .opacity(0.5)
                }
            }
        }
        .help(video.watch?.description ?? "")
        #if os(tvOS)
        .opacity(video.watch != nil ? 1.0 : 0.35)
        #else
        .disabled(video.watch == nil)
        #endif
    }
}

private extension URL {
    static let void: Self = Self(string: "#")!
}
