import SwiftUI

struct ColorStudyView: View {
    @EnvironmentObject var appState: AppState
    var artwork: Artwork

    var body: some View {
        VStack(spacing: 24) {
            Text("色彩学习")
                .font(.largeTitle)
                .bold()

            if let progress = appState.currentProgress {
                ProgressView(value: progress.colorStudyPercentage) {
                    Text("学习进度: \(Int(progress.colorStudyPercentage * 100))%")
                }
                .padding(.horizontal)
            }

            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ], spacing: 16) {
                    ForEach(artwork.colors, id: \.self) { color in
                        ColorCard(color: color)
                    }
                }
                .padding()
            }

            Button(action: {
                appState.updateColorStudyProgress()
                if appState.currentProgress?.isColorStudyComplete == true {
                    appState.navigate(to: .colorChallenge(artwork: artwork))
                }
            }) {
                Text("下一步")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct ColorCard: View {
    let color: Color

    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(height: 100)
                .cornerRadius(10)
        }
    }
}
