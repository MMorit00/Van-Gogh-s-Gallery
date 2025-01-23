import SwiftUI

struct WorkIntroView: View {
    let artwork: Artwork
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            HStack {
                Rectangle()
                    .fill(appState.currentColorScheme.lowerBackground)
                    .ignoresSafeArea()
                Rectangle()
                    .fill(appState.currentColorScheme.upperBackground)
                    .ignoresSafeArea()
            }

            GeometryReader { _ in
                HStack(spacing: 0) {
                    // 左侧深色区域
                    VStack(alignment: .leading, spacing: 0) {
                        // 主图
                        IntroImage(
                            imageName: artwork.imageName,
                            width: 671.5,
                            height: 456
                        )
                        .padding(.top,50)
                        .padding(.bottom, 16)
                        .offset(x: -24)
                        .zIndex(20)

                        VStack(alignment: .leading, spacing: 6) {
                            if let quote = artwork.artistQuote {
                                Text(quote)
                                  
                              Text("- Vincent van Gogh")
                            }
                        }
                        .serifH3_12_italic()
                        .frame(width: 392)
                        .padding(.leading, 96)
                        .foregroundColor(appState.currentColorScheme.textColor)

                        // 底部描述
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Painting Features")
                                .serifH0_36()
                                .foregroundColor(appState.currentColorScheme.textColor)
                                .padding(.top, 40)
                            Text(artwork.paintingFeatures)
                                .roundedH3_12()
                                .frame(width: 430)
                                .foregroundColor(appState.currentColorScheme.textColor)
                        }
                        .padding(.leading, 56)
                        Spacer()
                    }
                    .zIndex(10)
                    .ignoresSafeArea()

                    // 右侧浅色区域
                    VStack(spacing: 40) {
                        // 介绍文本
                        VStack(alignment: .leading) {
                            Text("Intro")
                                .serifH0_36()
                                .foregroundColor(appState.currentColorScheme.lowerBackground)
                                .padding(.bottom, 32)
                            Text(artwork.description)
                                .roundedH2_14()
                                .padding(.trailing, 121)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(appState.currentColorScheme.lowerBackground)
                        }

                        // 颜色部分
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Color")
                                .serifH0_36()
                                .foregroundColor(appState.currentColorScheme.lowerBackground)
                                .padding(.bottom, 32)
                            LazyVGrid(
                                columns: [
                                    GridItem(.fixed(160), spacing: 40),
                                    GridItem(.fixed(160), spacing: 40),
                                ],
                                alignment: .leading,
                                spacing: 32
                            ) {
                                ForEach(artwork.paletteInfo, id: \.colorName) { palette in
                                    ColorBlock(
                                        color: palette.color,
                                        title: palette.colorName
                                    ) {
                                        // 处理点击
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        // 底部按钮
                        Button(action: {
                            appState.navigate(to: .colorStudy(artwork: artwork))
                        }) {
                            Text("Let's Dive in")
                                .serifH0_36()
                                .foregroundColor(appState.currentColorScheme.upperBackground)
                                .padding(.horizontal, 88)
                                .padding(.vertical, 28)
                                .background(appState.currentColorScheme.lowerBackground)
                                .padding(.bottom,24)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .zIndex(1)
                 
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appState.currentColorScheme)
    }
}

#Preview {
    WorkIntroView(artwork: starryNight)
        .environmentObject(AppState())
}
