import Foundation

public class CouchData: ObservableObject, CustomStringConvertible {
    @Published public private(set) var videos: [Video] = []
    @Published public private(set) var genres: [String] = []
    @Published public var error: URLError?
    
    @Published public var filter: Video.Filter = .none {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    @Published public var sort: Video.Sort = .default {
        didSet {
            allVideos = nil ?? allVideos
        }
    }
    
    public var isEmpty: Bool {
        return allVideos.isEmpty
    }
    
    public func load(_ url: URL? = nil) {
        Task.init {
            do {
                let (data, _) = try await URLSession.shared.data(from: url ?? .data)
                guard let allVideos: [Video] = Table(data: data)?.records(Video.self) else {
                    throw URLError(.cannotDecodeContentData)
                }
                DispatchQueue.main.async {
                    self.allVideos = allVideos
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error as? URLError
                }
            }
        }
    }
    
    public init(_ url: URL? = nil) {
        load(url)
    }
    
    private var allVideos: [Video] = [] {
        didSet {
            videos = allVideos.filtered(by: filter).sorted(by: sort)
            genres = allVideos.genres
        }
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        switch filter {
        case .title, .genre, .format:
            return ["\(videos.count) of \(allVideos.count) videos", "\(filter)"].joined(separator: " ")
        case .none:
            return "\(videos.count) videos"
        }
    }
}
#if os(macOS) || os(iOS)

import SwiftUI
import UniformTypeIdentifiers

extension CouchData: Portable {
    
    // MARK: Portable
    public static let contentType: UTType = Spreadsheet.readableContentTypes.first!
    public static let defaultFilename: String? = URL.data.deletingPathExtension().relativeString
    
    public var file: FileDocument? {
        return Spreadsheet(Table(records: allVideos))
    }
}
#endif
