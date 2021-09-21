import SwiftUI
import HyperCouch
import CouchData

struct VideoLink: View {
    let video: Video
    
    init(_ video: Video) {
        self.video = video
    }
    
    // MARK: View
    var body: some View {
        Link(destination: video.watch ?? .void) {
            HStack {
                VStack(alignment: .leading) {
                    TitleView(video.title)
                    SubtitleView(video.subtitle)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if let service: URL.Service = video.watch?.service {
                    ServiceImage(service)
                        .foregroundColor(.secondary.opacity(0.75))
                        .frame(height: 47.0)
                }
            }
        }
        .help(video.watch?.description ?? "")
        .opacity(video.watch != nil ? 1.0 : 0.5)
    }
}

private extension URL {
    static let void: Self = Self(string: "#")!
}
