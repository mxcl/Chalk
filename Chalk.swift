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

public enum Style: Int {
    case bold = 1
    case dim = 2
    case italic = 3
    case underlined = 4
    case blink = 5
    case inverse = 7
    case hidden = 8  // for eg. passwords
    case strikethrough = 9  // not implemented in Terminal.app
}

private extension String.StringInterpolation {
    mutating func applyChalk(color: Color?, background: Color?, styles: Set<Style>, to any: Any) {
        appendLiteral("\u{001B}[")
        
        let codeSeparator = ";"
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
        
        if !styles.isEmpty {
            codeStrings.append(styles.map { "\($0.rawValue)" }.joined(separator: codeSeparator))
        }
        
        appendInterpolation(codeStrings.joined(separator: codeSeparator))
        
        appendLiteral("m")
        appendInterpolation("\(any)")
        appendLiteral("\u{001B}[0m")  // reset color, background, and style
    }
}

public extension String.StringInterpolation {
    mutating func appendInterpolation(_ any: Any, color: Color) {
        applyChalk(color: color, background: nil, styles: [], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, background: Color) {
        applyChalk(color: nil, background: background, styles: [], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, style: Style) {
        applyChalk(color: nil, background: nil, styles: [style], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, styles: Set<Style>) {
        applyChalk(color: nil, background: nil, styles: styles, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, background: Color) {
        applyChalk(color: color, background: background, styles: [], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, background: Color, style: Style) {
        applyChalk(color: nil, background: background, styles: [style], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, background: Color, styles: Set<Style>) {
        applyChalk(color: nil, background: background, styles: styles, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, style: Style) {
        applyChalk(color: color, background: nil, styles: [style], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, styles: Set<Style>) {
        applyChalk(color: color, background: nil, styles: styles, to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, background: Color, style: Style) {
        applyChalk(color: color, background: background, styles: [style], to: any)
    }
    
    mutating func appendInterpolation(_ any: Any, color: Color, background: Color, styles: Set<Style>) {
        applyChalk(color: color, background: background, styles: styles, to: any)
    }
}
