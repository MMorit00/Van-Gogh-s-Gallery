import SwiftUI

struct IntroView1: View {
    @EnvironmentObject var appState: AppState

    // 添加动画状态变量
    @State private var potatoOffset: CGFloat = 100 // 控制马铃薯图片偏移
    @State private var potatoOpacity: Double = 0
    @State private var starryOffset: CGFloat = -100 // 控制星空图片偏移
    @State private var starryOpacity: Double = 0
    @State private var showTexts: Bool = false
    @State private var isFloating = false // 控制持续动画

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 基础布局
                VStack(spacing: 0) {
                    IntroUpperSection(geometry: geometry, showTexts: showTexts)
                        .frame(height: 334)
                        .zIndex(6)
                    IntroLowerSection(geometry: geometry, showTexts: showTexts)
                        .frame(height: 488)
                        .zIndex(7)
                        .environmentObject(appState)
                }
                .ignoresSafeArea()

                // 马铃薯图片
                VStack {
                    IntroImage(imageName: "potato_eaters",
                               width: 530.50, height: 367.50)
                        .offset(x: potatoOffset)
                        .opacity(potatoOpacity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top, 70)
                .zIndex(10)
                .ignoresSafeArea()

                // 星空图片
                ZStack(alignment: .leading) {
                    IntroImage(imageName: "StarryNight",
                               width: 512, height: 357.50)
                        .offset(x: starryOffset)
                        .opacity(starryOpacity)
                }
                .background {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 394.50, height: 389)
                        .background(Color(red: 0.86, green: 0.91, blue: 0.95))
                        .frame(width: 394.50, height: 389)
                        .offset(x: 130, y: -74)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .ignoresSafeArea()
                .padding(.bottom, 64)
                .padding(.leading, 120)
                .zIndex(15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            // 触发入场动画序列
            withAnimation(.easeOut(duration: 0.8)) {
                potatoOffset = 0
                potatoOpacity = 1
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                starryOffset = 0
                starryOpacity = 1
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

// 修改上半部分子视图
private struct IntroUpperSection: View {
    let geometry: GeometryProxy
    let showTexts: Bool

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
        ZStack {
            Color(hex: "#F5F7F2")
            HStack(alignment: .center, spacing: 64) {
                VStack(alignment: .leading, spacing: 24) {
                    if showTexts {
                        Text("The Dark Palette Years: 1880-1886")
                            .serifH1_24_italic()
                            .foregroundColor(Color(red: 0.16, green: 0.18, blue: 0.14))
                            .transition(getTextTransition(0))

                        Text("Before his artistic awakening, Van Gogh explored various careers as an art dealer, teacher, and preacher. His early works, like \"The Potato Eaters\" (1885), used dark, earthy tones to capture the raw dignity of peasant life, setting the stage for his later transformation.")
                            .roundedH2_16()
                            .foregroundColor(Color(red: 0.16, green: 0.18, blue: 0.14))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 296)
                            .transition(getTextTransition(1))
                    }
                }
                .padding(.leading, 280)
                .padding(.top, 70)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

// 修改下半部分子视图
private struct IntroLowerSection: View {
    let geometry: GeometryProxy
    let showTexts: Bool
    @EnvironmentObject var appState: AppState

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
        ZStack {
            Color(red: 0.93, green: 0.95, blue: 0.98)

            VStack {
                HStack(alignment: .top, spacing: 40) {
                    VStack(spacing: 32) {
                        if showTexts {
                            Text("These formative years in the Netherlands shaped Van Gogh's deep connection to rural life and its people, though his art remained largely unrecognized. His dedication to capturing authentic human experiences would persist throughout his journey.")
                                .roundedH2_16()
                                .foregroundColor(Color(red: 0.09, green: 0.18, blue: 0.26))
                                .frame(maxWidth: 296)
                                .padding(.top, 32)
                                .transition(getTextTransition(2))

                            NextBT(color: Color(red: 0.08, green: 0.40, blue: 0.73)) {
                                appState.navigate(to: .intro(step: .second))
                            }
                            .padding(.bottom, 40)
                            .transition(getTextTransition(3))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.trailing, 137)
            }
        }
    }
}

#Preview {
    IntroView1()
        .environmentObject(AppState())
}
