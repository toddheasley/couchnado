import Foundation

struct HTML {
    let table: Table
    let title: String
    
    var data: Data {
        var html: [String] = []
        html.append("<!DOCTYPE html>")
        html.append("<title>\(title)</title>")
        html.append("<meta name=\"viewport\" content=\"initial-scale=1.0\">")
        html.append(stylesheet)
        html.append("<h1>\(title)</h1>")
        html.append("<table>")
        html.append("    <tr>")
        for head in table.schema {
            html.append("        <th>\(head)</th>")
        }
        html.append("    </tr>")
        for record in table.records {
            html.append("    <tr>")
            for data in record {
                let components: [String] = data.components(separatedBy: ", ")
                let strings: [String] = components.compactMap { string in
                    guard let url: URL = URL(string: string),
                          let service: URL.Service = url.service else {
                        return nil
                    }
                    return "<a href=\"\(url.absoluteString)\">\(service)</a>"
                }
                if components.count == strings.count  {
                    html.append("        <td>\(strings.joined(separator: ", "))</td>")
                } else {
                    html.append("        <td>\(data)</td>")
                }
            }
            html.append("    </tr>")
        }
        html.append("</table>")
        return html.joined(separator: "\n").data(using: .utf8)!
    }
}

private let stylesheet: String = """
<style>
    
    :root {
        --background: rgb(255, 255, 255);
        --color: rgb(0, 0, 0);
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --background: rgb(0, 0, 0);
            --color: rgb(255, 255, 255);
        }
    }
    
    * {
        -webkit-text-size-adjust: 100%;
        margin: 0;
        padding: 0;
    }
    
    body {
        background: var(--background);
        color: var(--color);
        font: 0.9em -apple-system, sans-serif;
    }
    
    h1 {
        font-size: 1.8em;
    }
    
</style>
"""
