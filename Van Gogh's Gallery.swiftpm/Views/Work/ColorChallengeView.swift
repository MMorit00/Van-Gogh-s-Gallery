import SwiftUI

struct ColorChallengeView: View {
    @EnvironmentObject var appState: AppState
    let artwork: Artwork
    @State private var selectedColor = Color(red: 0.51, green: 0.50, blue: 0.50) // 默认灰色
    @State private var currentPaletteIndex = 0
    @State private var matchingMessage = ""
    @State private var showMessage = false
    @State private var showCongrPopup = false

    private var currentPaletteInfo: PaletteInfo {
        artwork.paletteInfo[currentPaletteIndex]
    }

    private var progress: Double {
        Double(currentPaletteIndex) / Double(artwork.paletteInfo.count)
    }

    var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack(spacing: 0) {
                    Text("Color Challenge")
                        .serifH0_36()
                        .padding(.top, 48)

                    // Color blocks container
                    ZStack(alignment: .center) {
                        VStack(spacing: 0) {
                            // Target color block
                            Rectangle()
                                .fill(currentPaletteInfo.color)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    Text("Try to match the color you choose with the target color")
                                        .serifH2_16_italic()
                                        .foregroundColor(appState.currentColorScheme.upperBackground)
                                        .padding()
                                )
                                .cornerRadius(12, corners: [.topLeft, .topRight])

                            // Your color block
                            Rectangle()
                                .fill(selectedColor)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    Text("Your Color")
                                        .serifH2_16_italic()
                                        .foregroundColor(appState.currentColorScheme.upperBackground)
                                        .padding()
                                )
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 240)
                        .padding(.vertical, 50)

                        // Color Picker overlay
                        ColorPicker("", selection: $selectedColor)
                            .labelsHidden()
                            .scaleEffect(1.5)
                            .onChange(of: selectedColor) { _ in
                                checkColorMatch()
                            }
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 44, height: 44)
                            )
                    }
                    .shadow(color: .black.opacity(0.25), radius: 5, y: 2)

                    if showMessage {
                        Text(matchingMessage)
                            .roundedH2_16()
                            .foregroundColor(matchingMessage.contains("successful") ? .green : .orange)
                            .padding()
                    }

                    Spacer()

                    // Progress bar section
                    VStack(spacing: 16) {
                        ProgressBar(
                            progress: progress,
                            width: UIScreen.main.bounds.width - 80,
                            height: 15.5
                        )

                        Text("If the color challenge is successful(progress bar is 100%), it will automatically return to the gallery.")
                            .roundedH2_16()
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 40)
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(appState.currentColorScheme.upperBackground)
                .blur(radius: showCongrPopup ? 10 : 0)

                if showCongrPopup {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .transition(.opacity)

                    CongrPopup(
                        onNextTapped: {
                            withAnimation {
                                showCongrPopup = false
                                appState.navigate(to: .home)
                            }
                        },
                        type: .colorChallenge
                    )
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showCongrPopup)
    }

    private func checkColorMatch() {
        let selectedUIColor = UIColor(selectedColor)
        let targetUIColor = UIColor(
            hue: CGFloat(currentPaletteInfo.hue) / 360.0,
            saturation: CGFloat(currentPaletteInfo.saturation),
            brightness: CGFloat(currentPaletteInfo.brightness),
            alpha: 1.0
        )

        // 添加安全检查
        guard let (hueDiff, satDiff, brightDiff) = getColorDifference(selectedUIColor, targetUIColor) else {
            matchingMessage = "Please try selecting a color again"
            showMessage = true
            return
        }

        if isColorMatching(selectedUIColor, targetUIColor) {
            matchingMessage = "Color matching successful! Moving to next color..."
            showMessage = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                moveToNextColor()
            }
        } else {
            // 使用安全的差值比较
            if hueDiff > 0.1 {
                matchingMessage = "Adjust the hue (color tone) to match"
            } else if satDiff > 0.1 {
                matchingMessage = "Adjust the saturation (color intensity) to match"
            } else if brightDiff > 0.1 {
                matchingMessage = "Adjust the brightness to match"
            } else {
                matchingMessage = "Getting closer! Keep adjusting..."
            }
            showMessage = true
        }
    }

    private func getColorDifference(_ color1: UIColor, _ color2: UIColor) -> (CGFloat, CGFloat, CGFloat)? {
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        // 确保两个颜色都能成功转换为HSB
        guard color1.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1),
              color2.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        else {
            return nil
        }

        // 确保所有值都是有效的
        guard !h1.isNaN && !h2.isNaN && !s1.isNaN && !s2.isNaN && !b1.isNaN && !b2.isNaN else {
            return nil
        }

        let hueDiff = min(abs(h1 - h2), 1 - abs(h1 - h2))
        let satDiff = abs(s1 - s2)
        let brightDiff = abs(b1 - b2)

        return (hueDiff, satDiff, brightDiff)
    }

    private func isColorMatching(_ color1: UIColor, _ color2: UIColor) -> Bool {
        guard let (hueDiff, satDiff, brightDiff) = getColorDifference(color1, color2) else {
            return false
        }

        let tolerance: CGFloat = 0.2
        return hueDiff <= tolerance && satDiff <= tolerance && brightDiff <= tolerance
    }

    private func moveToNextColor() {
        if currentPaletteIndex + 1 < artwork.paletteInfo.count {
            withAnimation {
                currentPaletteIndex += 1
                showMessage = false
            }
        } else {
            // 显示完成弹窗
            withAnimation {
                showCongrPopup = true
            }
        }
    }
}

// 添加圆角辅助扩展
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ColorChallengeView(artwork: thePotatoEaters)
        .environmentObject(AppState())
}
