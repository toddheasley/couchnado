import SwiftUI
import Combine
import CouchData

@main
struct CouchnadoApp: App {
    
    var subscriber: AnyCancellable?
    
    init() {
        subscriber = CouchData.publisher()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print(error)
                fallthrough
            case .finished:
                break
            }
        }, receiveValue: { videos in
            for video in videos {
                print(" - \(video)")
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
