import Foundation

public enum Genre: String, Value, CaseIterable, Comparable, CustomStringConvertible {
    case action, adult, adventure, animation, anime, biography, comedy, crime, disaster, documentary, drama, epic, experimental, family, fantasy, gameshow = "game show", history, horror, kungfu = "kung fu", musical, mystery, oddball, political, romance, satire, scifi = "science fiction", sport, superhero, thriller, war, western
    
    // MARK: Comparable
    public static func < (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return rawValue
    }
}
