import SwiftUI

struct DecorativeCircles: View {
    // 定义常用颜色
    private let colors = CircleColors()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 大椭圆背景
                CircleShape(width: 336.43, height: 358.97)
                    .fill(colors.lightGreen)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .offset(x: 88, y: -190)


                // 深色小圆
                CircleShape(width: 192.84, height: 192.84)
                    .fill(colors.darkGray)
                    .offset(x: 70,y:-88)

                // 环形装饰
                CircleShape(width: 375.67, height: 375.67)
                    .stroke(colors.paleGreen, lineWidth: 27.13)
                    .position(x: geometry.size.width, y: -geometry.size.height)

                // 左侧深绿色圆
                CircleShape(width: 225.40, height: 225.40)
                    .fill(colors.darkGreen)
                    .offset(x: -90,y:-105)

                // 半透明浅绿色圆
                CircleShape(width: 225.40, height: 225.40)
                    .fill(colors.brightGreen)
                    .opacity(0.62)
                    .offset(x:-30,y:120)
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

// 颜色常量
private struct CircleColors {
    let lightGreen = Color(red: 0.65, green: 0.78, blue: 0.33)
    let darkGray = Color(red: 0.16, green: 0.18, blue: 0.14)
    let paleGreen = Color(red: 0.90, green: 0.92, blue: 0.88)
    let darkGreen = Color(red: 0.47, green: 0.58, blue: 0.20)
    let brightGreen = Color(red: 0.44, green: 0.73, blue: 0.16)
}

#Preview {
    DecorativeCircles()
        .frame(height: 160)
        .background(Color.white)
}
