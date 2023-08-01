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
            VStack(alignment: .leading, spacing: 1.0) {
                TitleLink(video: video)
                    .foregroundColor(.tableLink(video.about))
                SubtitleView(video.subtitle)
                    .foregroundColor(.tableForeground)
            }
            .foregroundColor(.tableForeground)
            Spacer()
            if let url: URL = video.watch {
                Link(destination: url) {
                    ServiceImage(url.service!)
                        .foregroundColor(.tableForeground.opacity(0.5))
                        .frame(height: 22.0)
                }
                .help(url.service!.description)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 9.5)
        .background(Color.tableRow(index))
        .cornerRadius(7.0)
    }
}

struct VideoView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VideoView(Video("The First Purge", format: .movie, era: "2018", links: [
            URL(string: "https://tv.apple.com/us/movie/the-first-purge/umc.cmc.7gv6zt29z4lv0ihxmubcrxr49")!,
            URL(string: "https://en.wikipedia.org/wiki/The_First_Purge")!
        ]))
        .padding()
    }
}
