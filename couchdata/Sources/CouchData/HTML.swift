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
        --background: #FFFFFF;
        --border: #B6D3C0;
        --color: #111111;
        --secondary: #CBE5D1;
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --background: #222222;
            --border: #444444;
            --color: #EEEEEE;
            --secondary: #333333;
        }
        
        a {
            color: inherit;
        }
    }
    
    body {
        background: var(--background);
        color: var(--color);
        font-family: ui-monospace, monospace;
        margin: 0;
    }
    
    table {
        border-collapse: collapse;
    }
    
    td, th {
        border: 1px solid var(--border);
        padding: 0.5em 1em;
        text-align: left;
        white-space: nowrap;
    }
    
    tr:nth-child(even) td {
        background: var(--secondary);
    }
    
</style>
"""
