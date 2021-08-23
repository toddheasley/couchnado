import Foundation

struct Anchor: Element {
    let href: URL
    
    init(_ content: Content, href: URL, title: String? = nil) {
        self.href = href
        self.content = Content(Tag("a", attributes: [], inline: ""))
        self.title = title
    }
    
    // MARK: Element
    let content: Content
    let title: String?
}
