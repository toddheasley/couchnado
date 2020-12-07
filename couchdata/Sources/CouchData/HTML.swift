import Foundation

struct HTML {
    let videos: [Video]
    let title: String
    
    var data: Data {
        var html: [String] = []
        html.append("<!DOCTYPE html>")
        html.append("<title>\(title)</title>")
        html.append("<meta name=\"viewport\" content=\"initial-scale=1.0\">")
        html.append("\(stylesheet)")
        html.append("\(script)")
        html.append("<nav>")
        html.append("    <input type=\"search\" placeholder=\"Search\" results=\"0\" list=\"filter\">")
        html.append("    <datalist id=\"filter\">")
        for genre in videos.genres {
            html.append("        <option>\(genre.capitalized)</option>")
        }
        html.append("        <option>&nbsp;</option>")
        for format in Video.Format.allCases {
            html.append("        <option>\(format.description.capitalized)</option>")
        }
        html.append("    </datalist>")
        html.append("</nav>")
        html.append("<table>")
        html.append("    <caption>\(videos.count) videos</caption>")
        for video in videos {
            html.append("    <tr data-filter=\"\(filter(for: video))\">")
            html.append("        <td>\(link("\(video.title)", href: video.link(for: .wikipedia))) <small>\(video.era) \(video.format)</small></td>")
            if let url: URL = video.links.last, url.service != .wikipedia {
                html.append("        <td>\(link("&#x25B6;", href: url))</td>")
            } else {
                html.append("        <td></td>")
            }
            html.append("    </tr>")
        }
        html.append("</table>")
        return html.joined(separator: "\n").data(using: .utf8)!
    }
    
    private func link(_ string: String, href url: URL? = nil) -> String {
        guard let url: URL = url else {
            return string
        }
        return "<a href=\"\(url.absoluteString)\" title=\"\(url.service?.description ?? url.absoluteString)\">\(string)</a>"
    }
    
    private func filter(for video: Video) -> String {
        let separator: String = " "
        return [
            video.title.description.tokenized(),
            video.genres.map({ $0.tokenized() }).joined(separator: separator),
            video.format.description.tokenized()
        ].joined(separator: separator)
    }
}

private let stylesheet: String = """
<style>
    
    body {
        font-family: ui-monospace, monospace;
        margin: 1em auto 2em auto;
        max-width: 540px;
    }
    
    caption {
        color: gray;
        font-size: smaller;
        margin: 0.5em;
    }
    
    input {
        font-size: 1em;
    }
    
    nav {
        display: none;
        margin: 1em -0.3em;
    }
    
    @media (max-width: 540px) {
        nav {
            margin: 1em 0.5em;
        }
    }
    
    small {
        display: block;
        font-weight:  normal;
        margin-top: 0.3em;
    }
    
    table {
        border-collapse: collapse;
        margin: 1em 0;
        width: 100%;
    }
    
    td {
        font-weight: bold;
        padding: 0.5em 1em;
    }
    
    td:last-child {
        text-align: right;
    }
    
    td:last-child a {
        background: gray;
        border-radius: 0.3em;
        color: gainsboro;
        display: inline-block;
        padding: 3px 0 6px 2px;
        text-align: center;
        text-decoration: none;
        width: 2em;
    }
        
    tr {
        background: #CBE5D1;
    }
    
    tr.odd {
        background: none;
    }
    
</style>
"""

private let script: String = """
<script src=\"https://code.jquery.com/jquery-3.5.1.slim.min.js\"></script>
<script>
    
    $(function() {
        $videos = $(\"tr\");
        
        $(\"input\").on(\"keyup change search\", function() {
            var filter = $(this).val().toLowerCase().replace(/[^0-9a-z]/g, \"\");
            var length = 0;
            $videos.each(function() {
                $(this).removeClass(\"odd\");
                if ($(this).data("filter").includes(filter)) {
                    if (length % 2 == 1) {
                        $(this).addClass(\"odd\");
                    }
                    $(this).show();
                    length += 1;
                } else {
                    $(this).hide();
                }
            });
            var caption = $videos.length + \" videos\";
            if (length < $videos.length) {
                caption = length + \" of \" + caption;
            }
            $(\"caption\").text(caption);
        }).change();
        
        $(\"nav\").show();
    });
    
</script>
"""
