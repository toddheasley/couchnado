import SwiftUI
import CouchData

struct VideoView: View {
    struct Item: Identifiable {
        let video: Video
        let index: Int
        
        // MARK: Identifiable
        var id: Int {
            return index
        }
    }
    
    let item: Item
    
    // MARK: View
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                TitleView(video: item.video)
                Text("\(item.video.era.description) \(item.video.format.description)")
                    .font(.callout)
                    .truncationMode(.tail)
                    .lineLimit(1)
            }
            Spacer()
            PlayButton(video: item.video)
        }
        .padding(.horizontal, .horizontal)
        .padding(.vertical, .vertical * 2.0)
        .background(Color.alternateBackground(item.index))
        .cornerRadius(2.0)
    }
}

fileprivate struct TitleView: View {
    let video: Video
    
    private var url: URL? {
        guard let url: URL = video.links.first, url.service == .wikipedia else {
            return nil
        }
        return url
    }
    
    private var action: (() -> Void) {
        return {
            guard let url: URL = url else {
                return
            }
            SearchView.endEditing()
            Safari.open(url: url)
        }
    }
    
    private func label() -> some View {
        Text(video.title.description)
            .font(Font.title3.weight(.semibold))
            .truncationMode(.tail)
            .lineLimit(1)
    }
    
    // MARK: View
    var body: some View {
        if url != nil {
            Button(action: action) {
                label()
            }
        } else {
            label()
        }
    }
}

fileprivate struct PlayButton: View {
    let video: Video
    
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
            SearchView.endEditing()
            Safari.open(url: url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: action) {
            Image(systemName: "play.rectangle.fill")
                .imageScale(.large)
                .font(.title)
                .foregroundColor(url != nil ? .gray : .clear)
        }
        .help(Text("Watch on \(URL.Service.apple.description)"))
    }
}
