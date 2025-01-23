import ColorKit
import SwiftUI

class ArtworkColorManager {
    func generateColorScheme(from image: UIImage) async throws -> ArtworkColorScheme {
        // 提取主要颜色
        let dominantColors = try await image.dominantColors(
            with: .best,
            algorithm: .kMeansClustering
        )

        guard let mainColor = dominantColors.first else {
            return .default
        }

        // 创建配色方案
        let (upper, lower, middle, decorative) = generateBackgroundColors(from: mainColor)
        let text = generateTextColor(for: lower)

        return ArtworkColorScheme(
            upperBackground: Color(upper),
            lowerBackground: Color(lower),
            middleColor: Color(middle),
            textColor: Color(text),
            decorativeLightColor: Color(decorative.light),
            decorativeDarkColor: Color(decorative.dark),
            decorativeBrightColor: Color(decorative.bright),
            decorativePaleColor: Color(decorative.pale),
            decorativeAccentColor: Color(decorative.accent)
        )
    }

    private func generateBackgroundColors(from color: UIColor) -> (
        upper: UIColor,
        lower: UIColor,
        middle: UIColor,
        decorative: (
            light: UIColor,
            dark: UIColor,
            bright: UIColor,
            pale: UIColor,
            accent: UIColor
        )
    ) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        // 基础颜色生成
        let upperColor = UIColor(
            hue: hue,
            saturation: max(saturation * 0.2, 0.05),
            brightness: min(brightness * 1.8, 0.98),
            alpha: 1.0
        )

        let lowerColor = UIColor(
            hue: hue,
            saturation: min(saturation * 0.8, 0.6),
            brightness: max(brightness * 0.2, 0.08),
            alpha: 1.0
        )

        let middleColor = UIColor(
            hue: hue,
            saturation: min(saturation * 1.2, 0.9),
            brightness: max(brightness * 0.7, 0.5),
            alpha: 1.0
        )

        // 装饰性颜色变体
        let decorativeLightColor = UIColor(
            hue: hue,
            saturation: min(saturation * 0.9, 0.7),
            brightness: min(brightness * 1.5, 0.85),
            alpha: 1.0
        )

        let decorativeDarkColor = UIColor(
            hue: hue,
            saturation: min(saturation * 0.6, 0.4),
            brightness: max(brightness * 0.3, 0.15),
            alpha: 1.0
        )

        let decorativeBrightColor = UIColor(
            hue: hue,
            saturation: min(saturation * 1.4, 0.95),
            brightness: min(brightness * 1.3, 0.9),
            alpha: 1.0
        )

        let decorativePaleColor = UIColor(
            hue: hue,
            saturation: max(saturation * 0.15, 0.1),
            brightness: min(brightness * 1.9, 0.95),
            alpha: 1.0
        )

        let decorativeAccentColor = UIColor(
            hue: hue,
            saturation: min(saturation * 1.3, 0.85),
            brightness: max(brightness * 0.6, 0.4),
            alpha: 1.0
        )

        return (
            upperColor,
            lowerColor,
            middleColor,
            (
                decorativeLightColor,
                decorativeDarkColor,
                decorativeBrightColor,
                decorativePaleColor,
                decorativeAccentColor
            )
        )
    }

    private func generateTextColor(for background: UIColor) -> UIColor {
        var brightness: CGFloat = 0
        background.getWhite(&brightness, alpha: nil)
        return brightness > 0.5 ? .black : .white
    }
}
