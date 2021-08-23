import Foundation

protocol Element {
    var content: Content {
        get
    }
    
    var title: String? {
        get
    }
}

extension Element {
    var title: String? {
        return nil
    }
}
