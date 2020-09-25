import SwiftUI
import CouchData

struct VideoView: View {
    let video: Video
    
    // MARK: View
    var body: some View {
        HStack {
            VStack {
                Text("\(video.title.description)")
            }
            Spacer()
        }
    }
}
