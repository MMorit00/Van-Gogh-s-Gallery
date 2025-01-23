import SwiftUI

struct WorkIntroView: View {
    let artwork: Artwork
    @EnvironmentObject var appState: AppState

    // 添加动画状态变量
    @State private var showMainImage: Bool = false
    @State private var showQuote: Bool = false
    @State private var showFeatures: Bool = false
    @State private var showRightContent: Bool = false
    @State private var showColorBlocks: Bool = false
    @State private var showButton: Bool = false

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
            HStack {
                Rectangle()
                    .fill(appState.currentColorScheme.lowerBackground)
                    .ignoresSafeArea()
                Rectangle()
                    .fill(appState.currentColorScheme.upperBackground)
                    .ignoresSafeArea()
            }
            .animation(.easeInOut(duration: 0.3), value: appState.currentColorScheme)

            GeometryReader { _ in
                HStack(spacing: 0) {
                    // 左侧深色区域
                    VStack(alignment: .leading, spacing: 0) {
                        // 主图
                        if showMainImage {
                            IntroImage(
                                imageName: artwork.imageName,
                                width: 671.5,
                                height: 456
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .offset(x: -24)
                           
                            .padding(.top, 50)
                            .padding(.bottom, 16)
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading)
                                    .combined(with: .opacity),
                                removal: .opacity
                            ))
                        }

                        // 引用部分
                        if showQuote {
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
                            .transition(getTextTransition(0))
                        }

                        // 特征描述
                        if showFeatures {
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
                            .transition(getTextTransition(1))
                        }
                        Spacer()
                    }
                    .zIndex(10)

                    // 右侧浅色区域
                    VStack(spacing: 40) {
                        if showRightContent {
                            // 介绍文本
                            VStack(alignment: .leading, spacing: 0) {
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
                            .transition(getTextTransition(2))
                        }

                        if showColorBlocks {
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
                                    ForEach(artwork.paletteInfo.indices, id: \.self) { index in
                                        ColorBlock(
                                            color: artwork.paletteInfo[index].color,
                                            title: artwork.paletteInfo[index].colorName
                                        ) {}
                                            .transition(getTextTransition(index + 3))
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(getTextTransition(3))
                        }

                        Spacer()

                        // 底部按钮
                        if showButton {
                            Button(action: {
                                appState.navigate(to: .colorStudy(artwork: artwork))
                            }) {
                                Text("Let's Dive in")
                                    .serifH0_36()
                                    .foregroundColor(appState.currentColorScheme.upperBackground)
                                    .padding(.horizontal, 88)
                                    .padding(.vertical, 28)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(appState.currentColorScheme.lowerBackground)
                                    )
                                    .padding(.bottom, 24)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(getTextTransition(4))
                        }
                    }
                    .zIndex(1)
                }
            }
        }
        .onAppear {
            // 触发入场动画序列
            withAnimation(.easeOut(duration: 0.8)) {
                showMainImage = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
                showQuote = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(0.5)) {
                showFeatures = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(0.7)) {
                showRightContent = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(0.9)) {
                showColorBlocks = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(1.1)) {
                showButton = true
            }
        }
    }
}

#Preview {
    WorkIntroView(artwork: starryNight)
        .environmentObject(AppState())
}
