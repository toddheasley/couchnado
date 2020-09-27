import SwiftUI
import CouchData

struct VideoView: View {
    struct Item: Identifiable, CustomStringConvertible {
        let video: Video
        let index: Int
        
        // MARK: Identifiable
        var id: Int {
            return index
        }
        
        // MARK: CustomStringConvertible
        var description: String {
            return "\(video.era.description) \(video.format.description)"
        }
    }
    
    let item: Item
    let size: CGSize
    
    init(item: Item, size: CGSize = .zero) {
        self.item = item
        self.size = size
    }
    
    private let width: CGFloat = 720.0
    
    // MARK: View
    var body: some View {
        #if os(iOS)
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                TitleView(video: item.video)
                Text("\(item.description)")
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
        #else
        Button(action: {
            guard let apple: URL = item.video.apple else {
                return
            }
            Safari.open(url: apple)
        }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(item.video.title.description)")
                        .font(.headline)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    Text("\(item.description)")
                        .truncationMode(.tail)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "play.fill")
                    .imageScale(.large)
                    .font(.headline)
                    .foregroundColor(item.video.apple != nil ? Color.primary.opacity(0.75) : .clear)
            }
            .frame(width: size.width * 0.8)
        })
        .disabled(item.video.apple == nil)
        #endif
    }
}

#if os(iOS)
fileprivate struct TitleView: View {
    let video: Video
    
    private func content() -> some View {
        return Text("\(video.title.description)")
            .font(Font.title3.weight(.semibold))
            .truncationMode(.tail)
            .lineLimit(1)
    }
    
    // MARK: View
    var body: some View {
        if let wikipedia: URL = video.wikipedia {
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
    
    private func content() -> some View {
        return Image(systemName: "play.rectangle.fill")
            .imageScale(.large)
            .font(.title)
            .foregroundColor(video.apple != nil ? .gray : .clear)
    }
    
    // MARK: View
    var body: some View {
        if let apple: URL = video.apple {
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
#endif

extension Video {
    fileprivate var wikipedia: URL? {
        guard let url: URL = links.first, url.service == .wikipedia else {
            return nil
        }
        return url
    }
    
    fileprivate var apple: URL? {
        guard let url: URL = links.last, url.service == .apple else {
            return nil
        }
        return url
    }
}
