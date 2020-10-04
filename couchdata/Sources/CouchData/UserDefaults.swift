import Foundation

extension UserDefaults {
    var showImport: Bool {
        set {
            set(newValue, forKey: "showImport")
        }
        get {
            return bool(forKey: "showImport")
        }
    }
    
    var showFilter: Bool {
        set {
            set(newValue, forKey: "showFilter")
        }
        get {
            return bool(forKey: "showFilter")
        }
    }
    
    var loadDate: Date {
        return Date(timeIntervalSince1970: double(forKey: "loadDate"))
    }
    
    @discardableResult func loaded(date: Date = Date()) -> Bool {
        let interval: TimeInterval = Date().timeIntervalSince1970 - loadDate.timeIntervalSince1970
        set(date.timeIntervalSince1970, forKey: "loadDate")
        return abs(interval) < 1.0
    }
}
