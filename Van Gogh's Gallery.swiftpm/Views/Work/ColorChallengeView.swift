import SwiftUI

struct ColorChallengeView: View {
    @EnvironmentObject var appState: AppState
    var artwork: Artwork
    @State private var selectedColor: Color?
    @State private var showResult: Bool = false
    @State private var isCorrect: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            Text("色彩挑战")
                .font(.largeTitle)
                .bold()

            if let progress = appState.currentProgress {
                ProgressView(value: progress.challengePercentage) {
                    Text("挑战进度: \(Int(progress.challengePercentage * 100))%")
                }
                .padding(.horizontal)
            }

            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ], spacing: 16) {
                    ForEach(artwork.colors, id: \.self) { color in
                        ColorChallengeCard(
                            color: color,
                            isSelected: selectedColor == color,
                            onTap: {
                                selectedColor = color
                                isCorrect = checkAnswer(color)
                                showResult = true
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .padding()
//        .alert(isPresent: $showResult) {
//            Alert(
//                title: Text(isCorrect ? "正确!" : "再试一次"),
//                message: Text(isCorrect ? "太棒了，继续下一个" : "仔细观察画作中的颜色"),
//                dismissButton: .default(Text("确定")) {
//                    if isCorrect {
//                        appState.updateChallengeProgress()
//                        selectedColor = nil
//                        if appState.currentProgress?.isChallengeComplete == true {
//                            appState.navigateToRoot()
//                        }
//                    }
//                }
//            )
//        }
    }

    private func checkAnswer(_: Color) -> Bool {
        // 这里添加判断逻辑
        return true
    }
}

struct ColorChallengeCard: View {
    let color: Color
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: 80)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
            )
            .onTapGesture(perform: onTap)
    }
}
