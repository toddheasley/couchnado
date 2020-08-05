import SwiftUI
import Combine
import CouchData

@main
struct CouchnadoApp: App {
    private static var subscriber: AnyCancellable?
    
    private func load(_ request: CouchData.Request = .default) {
        Self.subscriber?.cancel()
        Self.subscriber = CouchData.publisher(request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    fallthrough
                case .finished:
                    break
                }
            }, receiveValue: { videos in
                save(videos: videos)
            })
    }
    
    private func open() {
        #if os(macOS)
        Self.subscriber?.cancel()
        Self.subscriber = NSOpenPanel(fileTypes: [CouchData.FileFormat.tsv.pathExtension]).publisher
            .sink { urls in
                guard let url: URL = urls.first else {
                    return
                }
                self.load(.custom(url))
            }
        #endif
    }
    
    private func save(videos: [Video]) {
        #if os(macOS)
        let format: CouchData.FileFormat = .tsv
        Self.subscriber?.cancel()
        Self.subscriber = NSSavePanel().publisher(nameField: format.path(name: "Couchnado"))
            .sink { url in
                guard let url: URL = url else {
                    return
                }
                do {
                    try CouchData.write(videos: videos, to: url, file: format)
                } catch {
                    print(error)
                }
            }
        #endif
    }
    
    init() {
        //load()
        open()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
