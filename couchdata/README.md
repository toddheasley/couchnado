# `CouchData`

Behind Couchnado's slick interface and _powerful_ user features sits a single, static [tab-separated values (.tsv)](https://en.wikipedia.org/wiki/Tab-separated_values) spreadsheet. The [canonical list of movies and TV shows](https://toddheasley.github.io/couchnado/index.tsv) that `CouchData` loads by default is a shared [Numbers](https://www.apple.com/numbers) doc that me and [@brennaheaps](https://github.com/brennaheaps) started as an escape hatch during COVID-19 quarantine.

`CouchData` transforms spreadsheet rows and columns into video titles, links and genres. It also provides an API for:

* Loading a canonical spreadsheet from the web
* Filtering and sorting videos by title, genre and format
* Importing and exporting local spreadsheets

## `HyperCouch`

![](HyperCouch.png)

`HyperCouch` extends the `CouchData` API to include:

* Sharing a common palette of fonts, colors and graphics between SwiftUI and CSS
* Exporting spreadsheets as [single-page web app](https://toddheasley.github.io/couchnado)






## Requirements

Targets [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad)/[tvOS ](https://developer.apple.com/tvos) 15 and [macOS](https://developer.apple.com/macos) 12 Monterey. Written in [Swift](https://developer.apple.com/documentation/swift) 5.7 and builds in [Xcode](https://developer.apple.com/xcode) 14 or newer.
