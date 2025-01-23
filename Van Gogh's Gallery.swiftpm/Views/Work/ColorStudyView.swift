import SwiftUI

struct ColorStudyView: View {
    @EnvironmentObject var appState: AppState
    var artwork: Artwork
    @State private var showingColorInfo = false
    @State private var selectedPaletteInfo: PaletteInfo?
    @State private var matchedPaletteInfos: Set<Int> = []
    @State private var showingCongrPopup = false
    @State private var shouldShowPopup = false

    // 添加入场动画状态
    @State private var showTitle: Bool = false
    @State private var showImage: Bool = false
    @State private var showProgress: Bool = false

    // 添加常量样式
    private enum Style {
        static let backgroundColor = Color(red: 0.15, green: 0.20, blue: 0.15)
        static let textColor = Color(red: 0.90, green: 0.92, blue: 0.88)
    }

    private func getTextTransition(_ index: Int) -> AnyTransition {
        .asymmetric(
            insertion: .opacity
                .combined(with: .move(edge: .top))
                .combined(with: .scale(scale: 0.9))
                .animation(.easeInOut(duration: 0.6).delay(Double(index) * 0.2)),
            removal: .opacity.animation(.easeInOut(duration: 0.3))
        )
    }

    var body: some View {
        ZStack {
            // 深色背景
            appState.currentColorScheme.lowerBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // 1. 顶部文字
                if showTitle {
                    Text("**Click on** the colors in the painting, and you will gain an understanding of the meanings behind these colors.")
                        .roundedH1_24()
                        .foregroundColor(appState.currentColorScheme.textColor)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                        .padding(.bottom, 16)
                        .transition(getTextTransition(0))
                }

                // 2. 中间图片
                if showImage {
                    ImageViewWithColorDetection(
                        imageName: artwork.imageName,
                        onColorDetected: { color in
                            handleColorDetection(color)
                        }
                    )
                    .frame(width: 738, height: 576)
                    .padding(.bottom, 72)
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                }

                // 3. 底部进度条
                if showProgress {
                    if let progress = appState.currentProgress {
                        ProgressBar(
                            progress: progress.colorStudyPercentage,
                            width: UIScreen.main.bounds.width - 80,
                            height: 15.5
                        )
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    } else {
                        Text("Progress not initialized")
                            .foregroundColor(.red)
                    }
                }
            }
            .blur(radius: showingCongrPopup ? 10 : 0)
            .animation(.easeInOut(duration: 0.3), value: showingCongrPopup)

            // 完成弹窗
            if showingCongrPopup {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)

                CongrPopup {
                    withAnimation {
                        showingCongrPopup = false
                        appState.navigate(to: .colorChallenge(artwork: artwork))
                    }
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .sheet(isPresented: $showingColorInfo) {
            if shouldShowPopup {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showingCongrPopup = true
                }
            }
        } content: {
            if let paletteInfo = selectedPaletteInfo {
                ColorInfoSheetView(
                    color: paletteInfo.color,
                    title: paletteInfo.colorName,
                    hue: paletteInfo.hue,
                    saturation: paletteInfo.saturation,
                    brightness: paletteInfo.brightness,
                    explanation: paletteInfo.explanation
                )
                .presentationDetents([.height(400)])
                .presentationDragIndicator(.visible)
            }
        }
        .onAppear {
            // 确保进度被初始化
            appState.initializeProgress(for: artwork)

            // 触发入场动画序列
            withAnimation(.easeOut(duration: 0.6)) {
                showTitle = true
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                showImage = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(0.6)) {
                showProgress = true
            }
        }
    }

    private func handleColorDetection(_ detectedColor: UIColor) {
        // 找到最接近的颜色
        if let (index, paletteInfo) = findClosestColor(to: detectedColor) {
            selectedPaletteInfo = paletteInfo
            showingColorInfo = true

            // 如果是新匹配的颜色，更新进度
            if !matchedPaletteInfos.contains(index) {
                matchedPaletteInfos.insert(index)
                appState.updateColorStudyProgress()

                // 检查是否完成所有颜色
                if let progress = appState.currentProgress, progress.colorStudyPercentage >= 1.0 {
                    shouldShowPopup = true
                }
            }
        }
    }

    private func findClosestColor(to color: UIColor) -> (Int, PaletteInfo)? {
        var closestMatch: (Int, PaletteInfo)?
        var smallestDifference: CGFloat = .infinity

        for (index, paletteInfo) in artwork.paletteInfo.enumerated() {
            let paletteColor = UIColor(
                hue: CGFloat(paletteInfo.hue) / 360.0,
                saturation: CGFloat(paletteInfo.saturation),
                brightness: CGFloat(paletteInfo.brightness),
                alpha: 1.0
            )

            let difference = colorDifference(color, paletteColor)
            if difference < smallestDifference {
                smallestDifference = difference
                closestMatch = (index, paletteInfo)
            }
        }

        // 放宽颜色差异的阈值，让匹配更容易触发
        return smallestDifference < 0.5 ? closestMatch : nil
    }

    private func colorDifference(_ color1: UIColor, _ color2: UIColor) -> CGFloat {
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        color1.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)
        color2.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)

        // 计算色相差异（考虑色环）
        let hueDiff = min(abs(h1 - h2), 1 - abs(h1 - h2))

        // 计算饱和度和亮度的差异
        let satDiff = abs(s1 - s2)
        let brightDiff = abs(b1 - b2)

        // 给予不同的权重
        return hueDiff * 0.5 + satDiff * 0.25 + brightDiff * 0.25
    }
}

struct ImageViewWithColorDetection: UIViewRepresentable {
    let imageName: String
    let onColorDetected: (UIColor) -> Void

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        imageView.addGestureRecognizer(tapGesture)

        return imageView
    }

    func updateUIView(_: UIImageView, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        let parent: ImageViewWithColorDetection

        init(_ parent: ImageViewWithColorDetection) {
            self.parent = parent
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let imageView = gesture.view as? UIImageView,
                  let image = imageView.image else { return }

            let point = gesture.location(in: imageView)
            let color = getPixelColor(from: image, at: point, in: imageView)
            if let color = color {
                parent.onColorDetected(color)
            }
        }

        private func getPixelColor(from image: UIImage, at point: CGPoint, in imageView: UIImageView) -> UIColor? {
            // 转换坐标到图片空间
            let viewSize = imageView.bounds.size
            let imageSize = image.size

            // 计算实际显示的图片大小
            let scale = min(viewSize.width / imageSize.width, viewSize.height / imageSize.height)
            let scaledWidth = imageSize.width * scale
            let scaledHeight = imageSize.height * scale

            // 计算图片在视图中的偏移
            let offsetX = (viewSize.width - scaledWidth) / 2
            let offsetY = (viewSize.height - scaledHeight) / 2

            // 转换点击坐标到图片坐标系
            let imageX = (point.x - offsetX) / scale
            let imageY = (point.y - offsetY) / scale

            // 确保点击在图片范围内
            guard imageX >= 0 && imageX < imageSize.width &&
                imageY >= 0 && imageY < imageSize.height
            else {
                return nil
            }

            // 获取像素颜色
            guard let cgImage = image.cgImage,
                  let provider = cgImage.dataProvider,
                  let data = provider.data,
                  let pixels = CFDataGetBytePtr(data)
            else {
                return nil
            }

            let pixelX = Int(imageX)
            let pixelY = Int(imageY)
            let bytesPerPixel = 4
            let bytesPerRow = cgImage.bytesPerRow
            let index = (pixelY * bytesPerRow) + (pixelX * bytesPerPixel)

            let r = CGFloat(pixels[index]) / 255.0
            let g = CGFloat(pixels[index + 1]) / 255.0
            let b = CGFloat(pixels[index + 2]) / 255.0
            let a = CGFloat(pixels[index + 3]) / 255.0

            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
    }
}

#Preview {
    ColorStudyView(artwork: thePotatoEaters)
        .environmentObject(AppState())
}
