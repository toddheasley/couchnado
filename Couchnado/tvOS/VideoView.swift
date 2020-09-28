import SwiftUI
import CouchData

struct VideoView: View {
    let video: Video
    let size: CGSize?
    
    init(video: Video, size: CGSize? = nil) {
        self.video = video
        self.size = size != nil ? CGSize(width: size!.width * 0.75, height: size!.height) : nil
    }
    
    private var url: URL? {
        guard let url: URL = video.links.last, url.service == .apple else {
            return nil
        }
        return url
    }
    
    private var action: (() -> Void) {
        return {
            guard let url: URL = url else {
                return
            }
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading) {
                    Text(video.title.description)
                        .font(.headline)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    Text("\(video.era.description) \(video.format.description)")
                        .foregroundColor(.secondary)
                        .truncationMode(.tail)
                        .lineLimit(1)
                }
                Spacer()
                Image(systemName: "play.fill")
                    .imageScale(.large)
                    .opacity(url != nil ? 0.75 : .zero)
            }
            .frame(width: size?.width)
        }
        .help(Text("Watch on \(URL.Service.apple.description)"))
    }
}
