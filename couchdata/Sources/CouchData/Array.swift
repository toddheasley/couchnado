extension Array where Element == Video {
    var genres: [String] {
        var genres: [String] = []
        for video in self {
            genres += video.genres
        }
        return Set(genres).sorted()
    }
    
    func sorted(by sort: Video.Sort, reversed: Bool = false) -> [Video] {
        var videos: [Video] = self
        switch sort {
        case .title:
            videos = videos.sorted { $0.title < $1.title }
        case .era:
            videos = videos.sorted { $0.era < $1.era }
        }
        return reversed ? videos.reversed() : videos
    }
    
    func filtered(by filter: Video.Filter) -> [Video] {
        switch filter {
        case .title(let title):
            return self.filter { $0.matches(title) }
        case .genre(let genre):
            return self.filter { $0.genres.contains(genre.lowercased().value) }
        case .format(let format):
            return self.filter { $0.format == format }
        case .none:
            return self
        }
    }
}

extension Array: Value where Element: Value {
    
    // MARK: Value
    var value: String { map { $0.value }.joined(separator: ", ") }
    
    init?(value: String) {
        self = value.components(separatedBy: ",").compactMap { Element(value: $0.trimmingCharacters(in: .whitespacesAndNewlines))}
    }
}
