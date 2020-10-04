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
        html.append("<table>")
        html.append("    <tr>")
        for value in table.schema {
            html.append("        <th>\(value)</th>")
        }
        html.append("    </tr>")
        for record in table.records {
            html.append("    <tr>")
            for value in record {
                let components: [String] = value.components(separatedBy: ", ")
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
                    html.append("        <td>\(value)</td>")
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
        --border-color: rgb(220, 220, 220);
        --color: rgba(0, 0, 0, 0.9);
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --background: rgb(0, 0, 0);
            --border-color: rgb(35, 35, 35);
            --color: rgba(255, 255, 255, 0.8);
        }
    }
    
    a {
        opacity: 0.8;
    }
    
    @media (prefers-color-scheme: dark) {
        a {
            color: inherit;
            opacity: 1.0;
        }
    }
    
    body {
        background: var(--background);
        color: var(--color);
        font-family: system-ui, -apple-system, sans-serif;
        margin: 0;
    }
    
    table {
        border-collapse: collapse;
        display: inline-block;
        margin: 1.3em 1em;
    }
    
    th, td {
        border: 1px solid var(--border-color);
        padding: 0.3em;
        text-align: left;
        white-space: nowrap;
    }
    
</style>
"""
