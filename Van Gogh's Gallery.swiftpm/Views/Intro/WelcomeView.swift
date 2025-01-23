import SwiftUI

// MARK: - Constants

private enum Constants {
  static let backgroundColor = Color(hex: "#FCFAF0")
  static let darkBrownColor = Color(hex: "#3F3010")
  static let textColor = Color(hex: "#FAF5ED")
  static let goldColor = Color(hex: "#F7C45E")

  static let selfPortraitImage = "Van"
  static let MuseumImage = "Museum photo"
}

// 修改过渡效果
private func getTextTransition(_ index: Int) -> AnyTransition {
  .asymmetric(
    insertion: .opacity
      .combined(with: .move(edge: .bottom))
      .combined(with: .scale(scale: 0.8))
      .animation(.easeInOut(duration: 0.6).delay(Double(index) * 0.2)),
    removal: .opacity.animation(.easeInOut(duration: 0.3))
  )
}

struct WelcomeView: View {
  @EnvironmentObject var appState: AppState

  // 添加动画状态变量
  @State private var portraitOffset: CGFloat = 50 // 控制自画像偏移
  @State private var portraitOpacity: Double = 0 // 控制自画像透明度
  @State private var museumOffset: CGFloat = 100 // 控制博物馆照片偏移
  @State private var museumOpacity: Double = 0 // 控制博物馆照片透明度
  @State private var showTexts: Bool = false // 控制文字显示
  @State private var isFloating = false // 控制持续动画

  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        // 上半部分 - 浅色背景
        upperSection(geometry: geometry)
          .frame(height: geometry.size.height * 0.5)
          .background(Constants.backgroundColor)
          .zIndex(5)

        // 下半部分 - 深色背景
        lowerSection
          .frame(height: geometry.size.height * 0.5)
          .background(Constants.darkBrownColor)
      }
    }
  }

  private func upperSection(geometry _: GeometryProxy) -> some View {
    VStack(spacing: 0) {
      Spacer()

      HStack(alignment: .center, spacing: 150) {
        // 左侧图片区域
        ZStack {
          // 自画像
          IntroImage(
            imageName: Constants.selfPortraitImage,
            width: 299,
            height: 352
          )
          .padding(.leading, 112)
          .offset(y: portraitOffset)
          .opacity(portraitOpacity)
          // 添加持续的漂浮动画
          .offset(y: isFloating ? -5 : 5)
          .animation(
            Animation.easeInOut(duration: 2.0)
              .repeatForever(autoreverses: true),
            value: isFloating
          )

          // 博物馆照片
          IntroImage(
            imageName: Constants.MuseumImage,
            width: 220.50,
            height: 192
          )
          .offset(x: 155 + museumOffset, y: 120)
          .opacity(museumOpacity)
        }

        // 右侧文字区域
        VStack(alignment: .leading, spacing: 0) {
          if showTexts {
            Text("Explore Van Gogh's Art World")
              .serifH0_36()
              .foregroundColor(Color(hex: "#3B3307"))
              .padding(.bottom, 16)
              .transition(getTextTransition(0))

            Text("Experience the timeless masterpieces of the Post-Impressionist masters")
              .serifH2_16_italic()
              .frame(width: 342)
              .foregroundColor(.black)
              .padding(.bottom, 18)
              .transition(getTextTransition(1))

            Text("Step into the extraordinary world of Vincent van Gogh (1853-1890), where swirling stars, golden sunflowers, and vibrant landscapes come alive through bold colors and expressive brushstrokes. Discover the masterpieces that revolutionized modern art and continue to captivate audiences worldwide.")
              .frame(width: 342)
              .roundedH3_12()
              .foregroundColor(.black)
              .fixedSize(horizontal: false, vertical: true)
              .transition(getTextTransition(2))
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .onAppear {
      // 图片动画
      withAnimation(.easeOut(duration: 0.8)) {
        portraitOffset = 0
        portraitOpacity = 1
      }

      withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
        museumOffset = 0
        museumOpacity = 1
      }

      // 延迟显示文字
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        withAnimation {
          showTexts = true
        }
      }

      // 启动持续动画
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        isFloating = true
      }
    }
  }

  private var lowerSection: some View {
    HStack(alignment: .center, spacing: 40) {
      // 左侧文字
      VStack(alignment: .leading, spacing: 30) {
        Text("Begin Your Color Journey with Vincent van Gogh")
          .serifH1_24_italic()
          .foregroundColor(Constants.textColor)

        Text("Through his eyes, discover how colors can tell stories. From the vibrant yellows of sunflowers to the dreamy blues of starry nights, each shade carries a piece of Vincent's soul.\n\nReady to explore the world of colors that changed art forever?")
          .serifH1_24_italic()
          .foregroundColor(Constants.textColor)
          .lineSpacing(8)
      }
      .frame(width: 640)
      .fixedSize(horizontal: false, vertical: true)
      .padding(.leading, 120)
      .padding(.trailing, 103)

      // 右侧按钮
      NextBT(color: Constants.goldColor, action: {
        appState.navigate(to: .intro(step: .first))
      })
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - Supporting Views
