import SwiftUI

struct ArtworkColorScheme: Equatable {
    let upperBackground: Color // 上半部分背景色
    let lowerBackground: Color // 下半部分背景色
    let middleColor: Color // 中间色，用于进度条和强调色
    let textColor: Color // 文字颜色

    // 装饰圆圈的颜色变体
    let decorativeLightColor: Color // 浅色变体
    let decorativeDarkColor: Color // 深色变体
    let decorativeBrightColor: Color // 明亮变体
    let decorativePaleColor: Color // 淡色变体
    let decorativeAccentColor: Color // 强调色变体

    static let `default` = ArtworkColorScheme(
        upperBackground: Color(hex: "#EEF3F9"),
        lowerBackground: Color(hex: "#162D42"),
        middleColor: Color(hex: "#788C33"),
        textColor: .white,
        decorativeLightColor: Color(hex: "#A6C754"), // 浅绿色
        decorativeDarkColor: Color(hex: "#292D24"), // 深灰色
        decorativeBrightColor: Color(hex: "#70BA29"), // 亮绿色
        decorativePaleColor: Color(hex: "#E6EAE0"), // 淡绿色
        decorativeAccentColor: Color(hex: "#788C33") // 深绿色
    )

    static func == (lhs: ArtworkColorScheme, rhs: ArtworkColorScheme) -> Bool {
        return lhs.upperBackground == rhs.upperBackground &&
            lhs.lowerBackground == rhs.lowerBackground &&
            lhs.middleColor == rhs.middleColor &&
            lhs.textColor == rhs.textColor &&
            lhs.decorativeLightColor == rhs.decorativeLightColor &&
            lhs.decorativeDarkColor == rhs.decorativeDarkColor &&
            lhs.decorativeBrightColor == rhs.decorativeBrightColor &&
            lhs.decorativePaleColor == rhs.decorativePaleColor &&
            lhs.decorativeAccentColor == rhs.decorativeAccentColor
    }
}
