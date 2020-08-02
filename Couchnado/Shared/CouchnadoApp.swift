import SwiftUI
import Combine
import CouchData

@main
class CouchnadoApp: App {
    private(set) var videos: [Video] = [] {
        didSet {
            save()
        }
    }
    
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
            }, receiveValue: { [weak self] videos in
                self?.videos = videos
            })
    }
    
    private func open() {
        #if os(macOS)
        Self.subscriber?.cancel()
        Self.subscriber = NSOpenPanel(fileTypes: ["tsv"]).publisher
            .sink { urls in
                guard let url: URL = urls.first else {
                    return
                }
                self.load(.custom(url))
            }
        #endif
    }
    
    private func save() {
        #if os(macOS)
        Self.subscriber?.cancel()
        Self.subscriber = NSSavePanel().publisher(name: CouchData.path(name: "Couchnado"))
            .sink { url in
                guard let url: URL = url else {
                    return
                }
                do {
                    try CouchData.write(videos: self.videos, to: url)
                } catch {
                    print(error)
                }
            }
        #endif
    }
    
    required init() {
        open()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
