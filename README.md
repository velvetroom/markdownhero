# Markdown Hero
### The best markdown parser ever.

![iOS](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
![Swift](https://img.shields.io/badge/Swift-4.2-blue.svg)
[![Bitrise](https://app.bitrise.io/app/f50f3a6c0fff456c/status.svg?token=QR7AvYJSN5zhEH1qAwxXVA&branch=master)](https://app.bitrise.io/app/f50f3a6c0fff456c)

## Implementation

### Install

You can get MarkdownHero with **CocoaPods**.

Add to your Podfile

```
pod 'MarkdownHero'
```

Install and download

```
> pod install
```

If you are wondering what is CocoaPods take a look at: [https://cocoapods.org](https://cocoapods.org)

### Usage

Import MarkdownHero in your class

```
import MarkdownHero
```

Make a parser
```
let parser:Parser = Parser()
```

Let the magic begin

```
parser.parse(string:"# hello world") { [weak self] (result:NSAttributedString) in
    // use your attributed string
}
```

## Demo

Clone or download this repository, it contains a simple Demo application that will show you the power of MarkdownHero.
