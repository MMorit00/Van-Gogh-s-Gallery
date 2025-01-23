import SwiftUI

enum Typography {
    // 基础字体大小定义 - 已调整为CSS像素尺寸
    private enum Size {
        static let h0: CGFloat = 36 // H0/36pt
        static let h1: CGFloat = 24 // H1/24pt
        static let h2: CGFloat = 16 // H2/16pt
        static let h2_14: CGFloat = 14 // 新增 H2_14/14pt
        static let h3: CGFloat = 12 // H3/12pt
        static let h4: CGFloat = 9 // H4/9pt
    }

    // 字间距定义 - 已调整为CSS像素尺寸
    private enum Tracking {
        static let h1: CGFloat = 24 * 0.08
        static let h2: CGFloat = 1.28 // 16pt字体的字间距
        static let h3: CGFloat = 1.44
    }

    // 衬线字体 (New York)
    enum Serif {
        static let h0_36 = Font.system(size: Size.h0, design: .serif)
        static let h1_24 = Font.system(size: Size.h1, design: .serif)
        static let h2_16 = Font.system(size: Size.h2, design: .serif)
        static let h3_12 = Font.system(size: Size.h3, design: .serif)
        static let h4_9 = Font.system(size: Size.h4, design: .serif)

        // 斜体
        static let h0_36_italic = h0_36.italic()
        static let h1_24_italic = h1_24.italic()
        static let h2_16_italic = h2_16.italic()
        static let h3_12_italic = h3_12.italic()
        static let h4_9_italic = h4_9.italic()
    }

    // 圆角字体 (SF Pro Rounded) - 包含预设字间距
    enum Rounded {
        // 基础字体定义
        private static let h0_36_base = Font.system(size: Size.h0, design: .rounded)
        private static let h1_24_base = Font.system(size: Size.h1, design: .rounded)
        private static let h2_16_base = Font.system(size: Size.h2, design: .rounded)
        private static let h2_14_base = Font.system(size: Size.h2_14, design: .rounded) // 新增
        private static let h3_12_base = Font.system(size: Size.h3, design: .rounded)
        private static let h4_9_base = Font.system(size: Size.h4, design: .rounded)

        // 公开的字体视图修饰符
        static func h0_36() -> some ViewModifier {
            FontWithTracking(font: h0_36_base, tracking: 0)
        }

        static func h1_24() -> some ViewModifier {
            FontWithTracking(font: h1_24_base, tracking: 0)
        }

        static func h2_16() -> some ViewModifier {
            FontWithTracking(font: h2_16_base, tracking: Tracking.h2)
        }

        static func h2_14() -> some ViewModifier {
            FontWithTracking(font: h2_14_base, tracking: Tracking.h2)
        }

        static func h3_12() -> some ViewModifier {
            FontWithTracking(font: h3_12_base, tracking: Tracking.h3)
        }

        static func h4_9() -> some ViewModifier {
            FontWithTracking(font: h4_9_base, tracking: 0)
        }
    }
}

// 便捷使用扩展
extension View {
    // Serif 常规字体
    func serifH0_36() -> some View {
        font(Typography.Serif.h0_36)
    }

    func serifH1_24() -> some View {
        font(Typography.Serif.h1_24)
    }

    func serifH2_16() -> some View {
        font(Typography.Serif.h2_16)
    }

    func serifH3_12() -> some View {
        font(Typography.Serif.h3_12)
    }

    func serifH4_9() -> some View {
        font(Typography.Serif.h4_9)
    }

    // Serif 斜体
    func serifH0_36_italic() -> some View {
        font(Typography.Serif.h0_36_italic)
    }

    func serifH1_24_italic() -> some View {
        font(Typography.Serif.h1_24_italic)
    }

    func serifH2_16_italic() -> some View {
        font(Typography.Serif.h2_16_italic)
    }

    func serifH3_12_italic() -> some View {
        font(Typography.Serif.h3_12_italic)
    }

    func serifH4_9_italic() -> some View {
        font(Typography.Serif.h4_9_italic)
    }

    // 圆角字体便捷方法
    func roundedH0_36() -> some View {
        modifier(Typography.Rounded.h0_36())
    }

    func roundedH1_24() -> some View {
        modifier(Typography.Rounded.h1_24())
    }

    func roundedH2_16() -> some View {
        modifier(Typography.Rounded.h2_16())
    }

    func roundedH3_12() -> some View {
        modifier(Typography.Rounded.h3_12())
    }

    func roundedH4_9() -> some View {
        modifier(Typography.Rounded.h4_9())
    }

    // 新增圆角14pt字体便捷方法
    func roundedH2_14() -> some View {
        modifier(Typography.Rounded.h2_14())
    }
}

struct FontWithTracking: ViewModifier {
    let font: Font
    let tracking: CGFloat

    func body(content: Content) -> some View {
        content
            .font(font)
            .tracking(tracking)
    }
}
