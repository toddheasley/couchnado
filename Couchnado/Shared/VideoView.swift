import SwiftUI
import CouchData

struct VideoView: View {
    @EnvironmentObject private var data: CouchData
    
    var body: some View {
        Text("Videos")
            .padding()
        List {
            ForEach(data.videos) { video in
                Text(video.title.description)
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoView()
        }
    }
}
