import SwiftUI

struct ProgressBar: View {
    let progress: Double
    var width: CGFloat? = nil // 可选的宽度参数
    var height: CGFloat? = nil // 可选的高度参数

    // 将常量抽取到 ProgressBarStyle 中便于统一管理
    private enum Style {
        static let defaultHeight: CGFloat = 15.5
        static let backgroundColor = Color(red: 0.90, green: 0.92, blue: 0.88) // 浅色背景
        static let progressColor = Color(red: 0.47, green: 0.58, blue: 0.20) // 深绿色进度
        static let borderWidth: CGFloat = 1.25
        static let shadowRadius: CGFloat = 2
        static let shadowY: CGFloat = 2
        static let shadowColor = Color(red: 0, green: 0, blue: 0, opacity: 0.25)
    }

    // 抽取子视图使主视图更清晰
    private var backgroundBar: some View {
        Rectangle()
            .fill(Style.backgroundColor)
            .overlay(
                Rectangle()
                    .inset(by: -Style.borderWidth)
                    .stroke(Style.backgroundColor, lineWidth: Style.borderWidth)
            )
    }

    private var progressBar: some View {
        Rectangle()
            .fill(Style.progressColor)
            .overlay(
                Rectangle()
                    .inset(by: -Style.borderWidth)
                    .stroke(Style.backgroundColor, lineWidth: Style.borderWidth)
            )
    }

    private var textureOverlay: some View {
        Image("Texture")
            .resizable()
            .blendMode(.softLight)
            .shadow(
                color: Style.shadowColor,
                radius: Style.shadowRadius,
                y: Style.shadowY
            )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 背景条
                backgroundBar
                    .frame(width: width ?? geometry.size.width,
                           height: height ?? Style.defaultHeight)

                // 进度条
                progressBar
                    .frame(
                        width: min((width ?? geometry.size.width) * progress,
                                   width ?? geometry.size.width),
                        height: height ?? Style.defaultHeight
                    )

                // 纹理覆盖 - 覆盖整个进度条
                textureOverlay
                    .frame(width: width ?? geometry.size.width,
                           height: height ?? Style.defaultHeight)
                    .blendMode(.softLight)
            }
        }
        .frame(maxWidth: width ?? .infinity,
               maxHeight: height ?? Style.defaultHeight)
        // 添加动画
        .animation(.easeInOut, value: progress)
    }
}

// 添加预览
#Preview {
    VStack(spacing: 20) {
        // 默认全屏宽度
        ProgressBar(progress: 0.3)

        // 自定义宽度
        ProgressBar(progress: 0.7, width: 300)

        // 自定义宽度和高度
        ProgressBar(progress: 1.0, width: 200, height: 20)
    }
    .padding()
}
