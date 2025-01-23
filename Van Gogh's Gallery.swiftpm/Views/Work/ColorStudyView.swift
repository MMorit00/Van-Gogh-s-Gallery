import SwiftUI

struct ColorStudyView: View {
    @EnvironmentObject var appState: AppState
    var artwork: Artwork

    // 添加常量样式
    private enum Style {
        static let backgroundColor = Color(red: 0.15, green: 0.20, blue: 0.15)
        static let textColor = Color(red: 0.90, green: 0.92, blue: 0.88)
    }

    var body: some View {
        ZStack {
            // 深色背景
            Style.backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // 1. 顶部文字
                Text("**Click on** the colors in the painting, and you will gain an understanding of the meanings behind these colors.")
                .roundedH1_24()
                .foregroundColor(Style.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                    .padding(.bottom, 16)

                // 2. 中间图片
                Image(artwork.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 738, height: 576)
                    .padding(.bottom,72)
                  

                // 3. 底部进度条
//                if let progress = appState.currentProgress {
//                    ProgressBar(
//                        progress: progress.colorStudyPercentage,
//                        width: UIScreen.main.bounds.width - 80,
//                        height: 15.5
//                    )
//                    .padding(.horizontal, 40)
//                    .padding(.bottom, 40)
//                }
                ProgressBar(progress: 0.3)
              
            }
        }
    }
}



#Preview {
    ColorStudyView(artwork: .thePotatoEaters)
        .environmentObject(AppState())
}
