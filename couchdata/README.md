# `CouchData`

Behind Couchnado's slick interface and powerful user features sits a single, static [tab-separated values (.tsv)](https://en.wikipedia.org/wiki/Tab-separated_values) spreadsheet. The [canonical list of movies and TV shows](https://toddheasley.github.io/couchnado/index.tsv) that `CouchData` loads by default is a shared [Numbers](https://www.apple.com/numbers) doc where me and [@brennaheaps](https://github.com/brennaheaps) log anything worth watching again.

`CouchData` transforms spreadsheet rows and columns into video titles, links and genres. It also provides an API for:

* Loading a canonical spreadsheet from the web
* Filtering and sorting videos by title, genre and format
* Importing and exporting local spreadsheets

## `HyperCouch`

![](../docs/hypercouch.png)

`HyperCouch` extends the `CouchData` API to include:

* Sharing a common palette of fonts, colors and graphics between SwiftUI and CSS
* Exporting spreadsheets [for the web](https://toddheasley.github.io/couchnado)

| ![](../docs/platform.svg) | Written in [Swift](https://developer.apple.com/documentation/swift) 5.9 for [iOS](https://developer.apple.com/ios) 17 and aligned releases. Builds in [Xcode](https://developer.apple.com/xcode) 15 or newer. |