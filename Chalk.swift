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

public enum Style {
    case bold
}

public extension String.StringInterpolation {
    mutating func appendInterpolation(_ text: String, color: Color, style: Style? = nil) {
        appendLiteral("\u{001B}[")
        appendLiteral(String(color.rawValue))
        if style == .bold {
            appendLiteral(";1")
        }
        appendLiteral("m")
        appendLiteral(text)
        appendLiteral("\u{001B}[0m")  // resets color
    }
}
