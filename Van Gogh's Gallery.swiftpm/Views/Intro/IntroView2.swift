import SwiftUI

struct IntroView2: View {
    @EnvironmentObject var appState: AppState

    // 添加动画状态变量
    @State private var wheatfieldOffset: CGFloat = 100 // 控制麦田图片偏移
    @State private var wheatfieldOpacity: Double = 0
    @State private var sunflowersOffset: CGFloat = -100 // 控制向日葵图片偏移
    @State private var sunflowersOpacity: Double = 0
    @State private var showTexts: Bool = false

    private func getTextTransition(_ index: Int) -> AnyTransition {
        .asymmetric(
            insertion: .opacity
                .combined(with: .move(edge: .bottom))
                .combined(with: .scale(scale: 0.8))
                .animation(.easeInOut(duration: 0.6).delay(Double(index) * 0.2)),
            removal: .opacity.animation(.easeInOut(duration: 0.3))
        )
    }

    var body: some View {
        VStack(spacing: 32) {
            // 上半部分
            HStack(alignment: .top, spacing: 0) {
                // 左侧文本
                VStack(alignment: .leading, spacing: 38) {
                    if showTexts {
                        Text("The Color Revolution: 1886-1890")
                            .serifH1_24_italic()
                            .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.04))
                            .frame(width: 296)
                            .transition(getTextTransition(0))

                        Text("Moving to France marked a turning point in Van Gogh's artistic journey. Inspired by the vibrant atmosphere and fellow artists, his palette transformed from dark earth tones to explosive colors.")
                            .roundedH2_16()
                            .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.04))
                            .transition(getTextTransition(1))
                    }
                }
                .ignoresSafeArea()
                .padding(.trailing, 48)
                .padding(.leading, 200)

                // 右侧麦田图片
                IntroImage(imageName: "Wheatfield with Crows",
                           width: 544.5,
                           height: 272)
                    .offset(x: wheatfieldOffset)
                    .opacity(wheatfieldOpacity)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)

            // 下半部分
            HStack(alignment: .center, spacing: 0) {
                // 左侧向日葵图片
                IntroImage(imageName: "Sunflowers",
                           width: 328,
                           height: 404.5)
                    .offset(x: sunflowersOffset)
                    .opacity(sunflowersOpacity)
                    .padding(.leading, 192)
                    .padding(.trailing, 106)

                // 右侧文本
                VStack(alignment: .center, spacing: 0) {
                    if showTexts {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("In his final years, he created masterpieces like \"Sunflowers\" and \"Wheatfield with Crows\". These works, with their bold colors and expressive brushstrokes, would later revolutionize modern art and continue to move audiences worldwide.")
                                .transition(getTextTransition(2))

                            Text("Now, let's step into Van Gogh's gallery and explore the power of his revolutionary use of color.")
                                .bold()
                                .transition(getTextTransition(3))
                        }
                        .roundedH2_16()
                        .frame(width: 395)
                        .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.04))

                        // Next按钮
                        NextBT(color: Color(red: 0.89, green: 0.79, blue: 0.28)) {
                            appState.navigateToHome()
                        }
                        .offset(y: 52)
                        .transition(getTextTransition(4))
                    }
                }
            }
            .offset(y: -78)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.99, green: 0.98, blue: 0.94))
        .onAppear {
            // 触发入场动画序列
            withAnimation(.easeOut(duration: 0.8)) {
                wheatfieldOffset = 0
                wheatfieldOpacity = 1
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                sunflowersOffset = 0
                sunflowersOpacity = 1
            }

            // 延迟显示文字
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation {
                    showTexts = true
                }
            }
        }
    }
}

#Preview {
    IntroView2()
}
