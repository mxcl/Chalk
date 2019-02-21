public enum Color: Int {
    case black = 30
    case red = 31
    case green = 32
    case yellow = 33
    case blue = 34
    case magenta = 35
    case cyan = 36
    case white = 37
}

public enum Style: Int {
    case bold = 1
    case underline = 4
    case italic = 3
    case strikethrough = 9  // not implemented in Terminal.app
}

public extension String.StringInterpolation {
    mutating func appendInterpolation(_ any: Any, color: Color, style: Style? = nil) {
        appendLiteral("\u{001B}[")
        appendLiteral(String(color.rawValue))
        if let style = style?.rawValue {
            appendInterpolation(";\(style)")
        }
        appendLiteral("m")
        appendInterpolation("\(any)")
        appendLiteral("\u{001B}[0m")  // resets color
    }
}

public extension String.StringInterpolation {
    mutating func appendInterpolation(_ any: Any, color: UInt8, background: UInt8? = nil) {
        appendInterpolation("\u{001B}[38;5;\(color)")
        if let bg = background {
            appendInterpolation(";48;5;\(bg)")
        }
        appendLiteral("m")
        appendInterpolation("\(any)")
        appendLiteral("\u{001B}[0m")  // resets color
    }
}
