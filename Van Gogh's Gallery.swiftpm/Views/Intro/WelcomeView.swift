import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("欢迎来到梵高画廊")
                .font(.largeTitle)
                .bold()

            Text("开始探索梵高的艺术世界")
                .font(.title2)

            Button(action: {
                appState.navigate(to: .intro(step: .first))
            }) {
                Text("开始探索")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
