import SwiftUI

struct WorkIntroView: View {
    @EnvironmentObject var appState: AppState
    var artwork: Artwork

    var body: some View {
        VStack(spacing: 24) {
            Text(artwork.title)
                .font(.largeTitle)
                .bold()

            Text(artwork.year)
                .font(.title2)
                .foregroundColor(.gray)

            Text(artwork.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack(spacing: 16) {
                Button(action: {
                    appState.navigate(to: .colorStudy(artwork: artwork))
                }) {
                    Text("开始色彩学习")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                Button(action: {
                    appState.navigateToRoot()
                }) {
                    Text("返回主页")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
