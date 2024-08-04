protocol Record {
    var schema: [String] { get }
    var record: [String] { get }
    
    init?(record: [String])
}
