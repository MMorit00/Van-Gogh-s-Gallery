import SwiftUI

struct DecorativeCircles: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 大椭圆背景
                CircleShape(width: 336.43, height: 358.97)
                    .fill(appState.currentColorScheme.decorativeLightColor)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .offset(x: 88, y: -190)

                // 深色小圆
                CircleShape(width: 192.84, height: 192.84)
                    .fill(appState.currentColorScheme.decorativeDarkColor)
                    .offset(x: 70, y: -88)

                // 环形装饰
                CircleShape(width: 375.67, height: 375.67)
                    .stroke(appState.currentColorScheme.decorativePaleColor, lineWidth: 27.13)
                    .position(x: geometry.size.width, y: -geometry.size.height)

                // 左侧深绿色圆
                CircleShape(width: 225.40, height: 225.40)
                    .fill(appState.currentColorScheme.decorativeAccentColor)
                    .offset(x: -90, y: -105)

                // 半透明浅绿色圆
                CircleShape(width: 225.40, height: 225.40)
                    .fill(appState.currentColorScheme.decorativeBrightColor)
                    .opacity(0.42)
                    .offset(x: -30, y: 120)
            }
        }
    }
}

// 圆形形状组件
private struct CircleShape: Shape {
    let width: CGFloat
    let height: CGFloat

    func path(in _: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: CGRect(x: 0, y: 0, width: width, height: height))
        return path
    }
}

#Preview {
    DecorativeCircles()
        .frame(height: 160)
        .background(Color.white)
        .environmentObject(AppState())
}
