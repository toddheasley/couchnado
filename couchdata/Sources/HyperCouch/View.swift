import SwiftUI
import CouchData

extension View {
    public func webPage(_ data: CouchData, isExporting: Binding<Bool>) -> some View {
        let page: WebPage? = HyperCouch(data).file as? WebPage
        return fileExporter(isPresented: isExporting, document: page, contentType: HyperCouch.contentType, defaultFilename: HyperCouch.defaultFilename) { result in
            switch result {
            case .success(let url):
                do {
                    for resource in page?.resources ?? [] {
                        try resource.save(url)
                    }
                } catch {
                    data.error = error as? URLError ?? URLError(.cannotWriteToFile)
                }
            case .failure(let error):
                data.error = error as? URLError ?? URLError(.cannotWriteToFile)
            }
        }
    }
}
