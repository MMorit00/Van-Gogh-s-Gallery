import SwiftUI

struct IntroView2: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("探索色彩")
                .font(.largeTitle)
                .bold()

            Text("让我们一起探索梵高绘画中的色彩运用")
                .font(.title2)
                .multilineTextAlignment(.center)

            Button(action: {
                appState.navigate(to: .home)
            }) {
                Text("进入主页")
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
