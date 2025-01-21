import SwiftUI  



extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

enum Colors {
    // 背景色系
    enum Background {
        static let primary = Color(hex: "#F5F7F2")
        static let secondary = Color(hex: "#EDF2FA") 
        static let tertiary = Color(hex: "#FCFAF0")
        static let quaternary = Color(hex: "#E6EAE0")
    }
    
    // 主题色系
    enum Theme {
        static let primary = Color(hex: "#789433")
        static let secondary = Color(hex: "#1466BA")
        static let accent = Color(hex: "#F7C45E")
        static let accentAlt = Color(hex: "#E3C947")
    }
    
    // 深色系
    enum Dark {
        static let primary = Color(hex: "#292D24")
        static let secondary = Color(hex: "#172E42")
        static let tertiary = Color(hex: "#40310F")
        static let quaternary = Color(hex: "#3A330A")
    }
    
    // 灰度系
    enum Gray {
        static let light = Color(hex: "#E0E6DB")
        static let medium = Color(hex: "#A6AB9B")
        static let dark = Color(hex: "#6D7563")
        static let darker = Color(hex: "#5C6156")
        static let darkest = Color(hex: "#3D403A")
    }
}
