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
    let size: CGSize
    
    private let width: CGFloat = 720.0
    
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
        .padding(.horizontal, max((size.width - width) * 0.5, .horizontal))
        .padding(.vertical, .vertical * 2.0)
        .background(Color.alternateBackground(item.index))
        .cornerRadius(1.0)
    }
}

fileprivate struct TitleView: View {
    let video: Video
    
    private var wikipedia: URL? {
        guard let url: URL = video.links.first, url.service == .wikipedia else {
            return nil
        }
        return url
    }
    
    private func content() -> some View {
        return Text("\(video.title.description)")
            .font(Font.title3.weight(.semibold))
            .truncationMode(.tail)
            .lineLimit(1)
    }
    
    // MARK: View
    var body: some View {
        if let wikipedia: URL = wikipedia {
            Button(action: {
                SearchView.endEditing()
                Safari.open(url: wikipedia)
            }, label: {
                content()
            })
            .help(Text("Read Wikipedia Entry"))
        } else {
            content()
        }
    }
}

fileprivate struct PlayButton: View {
    let video: Video
    
    private var apple: URL? {
        guard let url: URL = video.links.last, url.service == .apple else {
            return nil
        }
        return url
    }
    
    private func content() -> some View {
        return Image(systemName: "play.rectangle.fill")
            .imageScale(.large)
            .font(.title)
            .foregroundColor(apple != nil ? .gray : .clear)
    }
    
    // MARK: View
    var body: some View {
        if let apple: URL = apple {
            Button(action: {
                SearchView.endEditing()
                Safari.open(url: apple)
            }, label: {
                content()
            })
            .help(Text("Watch on Apple TV"))
        } else {
            content()
        }
    }
}
