import SwiftUI
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
                }
            }
        }
        .help(video.watch?.description ?? "")
        .opacity(video.watch != nil ? 1.0 : 0.5)
    }
}

struct VideoLink_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VideoLink(Video("The First Purge", format: .movie, era: "2018", links: [
            URL(string: "https://tv.apple.com/us/movie/the-first-purge/umc.cmc.7gv6zt29z4lv0ihxmubcrxr49")!,
            URL(string: "https://en.wikipedia.org/wiki/The_First_Purge")!
        ]))
        .padding()
    }
}

private extension URL {
    static let void: Self = Self(string: "#")!
}
