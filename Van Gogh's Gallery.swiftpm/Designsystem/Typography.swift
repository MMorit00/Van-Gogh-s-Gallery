
import SwiftUI 

//! 暂时的问题： 我要将字母间距融合到rounded字体中 ，其中
import SwiftUI 

enum Typography {
    // 基础字体大小定义
    private enum Size {
        static let h0: CGFloat = 72  // H0/72pt
        static let h1: CGFloat = 48  // H1/48pt
        static let h2: CGFloat = 32  // H2/32pt - tracking 2.56 (32 * 0.08)
        static let h3: CGFloat = 24  // H3/24pt - tracking 2.88 (24 * 0.12)
        static let h4: CGFloat = 18  // H4/18pt
    }
    
    // 字间距定义 - 仅用于圆角字体的特定字号
    private enum Tracking {
        static let h2: CGFloat = 2.56  // 32pt字体的字间距
        static let h3: CGFloat = 2.88  // 24pt字体的字间距
    }
    
    // 衬线字体 (New York)
    enum Serif {
        static let h0_72 = Font.system(size: Size.h0, design: .serif)
        static let h1_48 = Font.system(size: Size.h1, design: .serif)
        static let h2_32 = Font.system(size: Size.h2, design: .serif)
        static let h3_24 = Font.system(size: Size.h3, design: .serif)
        static let h4_18 = Font.system(size: Size.h4, design: .serif)
        
        // 斜体
        static let h0_72_italic = h0_72.italic()
        static let h1_48_italic = h1_48.italic()
        static let h2_32_italic = h2_32.italic()
        static let h3_24_italic = h3_24.italic()
        static let h4_18_italic = h4_18.italic()
    }
    
    // 圆角字体 (SF Pro Rounded) - 包含预设字间距
    enum Rounded {
        // 基础字体定义
        private static let h0_72_base = Font.system(size: Size.h0, design: .rounded)
        private static let h1_48_base = Font.system(size: Size.h1, design: .rounded)
        private static let h2_32_base = Font.system(size: Size.h2, design: .rounded)
        private static let h3_24_base = Font.system(size: Size.h3, design: .rounded)
        private static let h4_18_base = Font.system(size: Size.h4, design: .rounded)
        
        // 公开的字体视图修饰符
        static func h0_72() -> some ViewModifier {
            FontWithTracking(font: h0_72_base, tracking: 0)
        }
        
        static func h1_48() -> some ViewModifier {
            FontWithTracking(font: h1_48_base, tracking: 0)
        }
        
        static func h2_32() -> some ViewModifier {
            FontWithTracking(font: h2_32_base, tracking: Tracking.h2)
        }
        
        static func h3_24() -> some ViewModifier {
            FontWithTracking(font: h3_24_base, tracking: Tracking.h3)
        }
        
        static func h4_18() -> some ViewModifier {
            FontWithTracking(font: h4_18_base, tracking: 0)
        }
    }
}

// ... FontWithTracking 保持不变 ...

// 便捷使用扩展
extension View {
  
    func serifH0_72() -> some View {
        self.font(Typography.Serif.h0_72)
    }
    
    func serifH1_48() -> some View {
        self.font(Typography.Serif.h1_48)
    }
    
    func serifH2_32() -> some View {
        self.font(Typography.Serif.h2_32)
    }
    
    func serifH3_24() -> some View {
        self.font(Typography.Serif.h3_24)
    }
    
    func serifH4_18() -> some View {
        self.font(Typography.Serif.h4_18)
    }
    
   
    func serifH0_72_italic() -> some View {
        self.font(Typography.Serif.h0_72_italic)
    }
    
    func serifH1_48_italic() -> some View {
        self.font(Typography.Serif.h1_48_italic)
    }
    
    func serifH2_32_italic() -> some View {
        self.font(Typography.Serif.h2_32_italic)
    }
    
    func serifH3_24_italic() -> some View {
        self.font(Typography.Serif.h3_24_italic)
    }
    
    func serifH4_18_italic() -> some View {
        self.font(Typography.Serif.h4_18_italic)
    }
    
    // 圆角字体便捷方法
    func roundedH0_72() -> some View {
        self.modifier(Typography.Rounded.h0_72())
    }
    
    func roundedH1_48() -> some View {
        self.modifier(Typography.Rounded.h1_48())
    }
    
    func roundedH2_32() -> some View {
        self.modifier(Typography.Rounded.h2_32())
    }
    
    func roundedH3_24() -> some View {
        self.modifier(Typography.Rounded.h3_24())
    }
    
    func roundedH4_18() -> some View {
        self.modifier(Typography.Rounded.h4_18())
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