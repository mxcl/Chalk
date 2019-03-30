public enum Color: RawRepresentable {
    case black
    case red
    case green
    case yellow
    case blue
    case magenta
    case cyan
    case white
    case extended(UInt8)
    
    public init?(rawValue: UInt8) {
        switch rawValue {
            case 0: self = .black
            case 1: self = .red
            case 2: self = .green
            case 3: self = .yellow
            case 4: self = .blue
            case 5: self = .magenta
            case 6: self = .cyan
            case 7: self = .white
            default: self = .extended(rawValue)
        }
    }
    
    public var rawValue: UInt8 {
        switch self {
            case .black: return 0
            case .red: return 1
            case .green: return 2
            case .yellow: return 3
            case .blue: return 4
            case .magenta: return 5
            case .cyan: return 6
            case .white: return 7
            case .extended(let number): return number
        }
    }
}

public struct Style: OptionSet {
    public static let bold = Style(rawValue: 1 << 0)
    public static let dim = Style(rawValue: 1 << 1)
    public static let italic = Style(rawValue: 1 << 2)
    public static let underlined = Style(rawValue: 1 << 3)
    public static let blink = Style(rawValue: 1 << 4)
    public static let inverse = Style(rawValue: 1 << 5)
    public static let hidden = Style(rawValue: 1 << 6)  // for eg. passwords
    public static let strikethrough = Style(rawValue: 1 << 7)  // not implemented in Terminal.app

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

private extension String.StringInterpolation {
    mutating func applyChalk(color: Color?, background: Color?, style: Style?, to any: Any) {
        appendLiteral("\u{001B}[")

        var codeStrings: [String] = []
        
        if let color = color?.rawValue {
            codeStrings.append("38")
            codeStrings.append("5")
            codeStrings.append("\(color)")
        }
        
        if let background = background?.rawValue {
            codeStrings.append("48")
            codeStrings.append("5")
            codeStrings.append("\(background)")
        }

        if let style = style {
            let lookups: [(Style, Int)] = [(.bold, 1), (.dim, 2), (.italic, 3), (.underlined, 4), (.blink, 5), (.inverse, 7), (.hidden, 8), (.strikethrough, 9)]
            for (key, value) in lookups where style.contains(key) {
                codeStrings.append(String(value))
            }
        }

        appendInterpolation(codeStrings.joined(separator: ";"))
        
        appendLiteral("m")
        appendInterpolation("\(any)")
        appendLiteral("\u{001B}[0m")  // reset color, background, and style
    }
}

public extension String.StringInterpolation {
    mutating func appendInterpolation(_ any: Any, color: Color) {
        applyChalk(color: color, background: nil, style: nil, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, background: Color) {
        applyChalk(color: nil, background: background, style: nil, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, style: Style) {
        applyChalk(color: nil, background: nil, style: style, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, background: Color) {
        applyChalk(color: color, background: background, style: nil, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, background: Color, style: Style) {
        applyChalk(color: nil, background: background, style: style, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, style: Style) {
        applyChalk(color: color, background: nil, style: style, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, background: Color, style: Style) {
        applyChalk(color: color, background: background, style: style, to: any)
    }
}
