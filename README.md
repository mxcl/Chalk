# Chalk

Terminal colors using Swift 5’s string interpolation extensions.

<img src="../gh-pages/Screenshot.1.png" width="467">

```swift
import Chalk  // @mxcl ~> 0.3

let colorString = "blue"
print("Here’s \(colorString, color: .blue)!")
```

# Name

[Chalk] by [@sindresorhus] is an extremely famous Node package for the same
purpose. Open source is facilitated by naming connections, we picked the same
name to enable those mental connections.

This package is called Chalk, or `mxcl/Chalk` or Chalk for Swift when
disambiguating.

[@sindresorhus]: https://github.com/sindresorhus
[Chalk]: https://github.com/chalk/chalk

# Support mxcl

Hey there, I’m Max Howell, a prolific producer of open source and probably you
already use some of it (I created [`brew`]). I work full-time on open source and
it’s hard; currently *I earn less than minimum wage*. Please help me continue my
work, I appreciate it 🙏🏻

<a href="https://www.patreon.com/mxcl">
	<img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

[Other ways to say thanks](http://mxcl.dev/#donate).

[`brew`]: https://brew.sh

# Demo

If you have [`swift-sh`]:

```
$ swift sh <<EOF
import Foundation
import Chalk  // @mxcl ~> 0.3

for x in 0..<256 {
    let cell = " \(x)".padding(toLength: 5, withPad: " ", startingAt: 0)
    let terminator = (x + 3).isMultiple(of: 6) ? "\n" : ""
    print("\(cell, color: 15, background: UInt8(x))", terminator: terminator)
}
EOF
```

Will give you:

<img src='../gh-pages/Screenshot.2.png' width='572'>

[`swift-sh`]: https://github.com/mxcl/swift-sh

# Installation

SwiftPM:

```swift
package.append(.package(url: "https://github.com/mxcl/Chalk.git", from: "0.1.0"))
```

Carthage:

> Waiting on: [@Carthage#1945](https://github.com/Carthage/Carthage/pull/1945).
