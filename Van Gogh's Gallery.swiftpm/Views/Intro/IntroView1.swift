import SwiftUI

struct IntroView1: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("认识梵高")
                .font(.largeTitle)
                .bold()

            Text("梵高是19世纪最具影响力的画家之一")
                .font(.title2)
                .multilineTextAlignment(.center)

            Button(action: {
                appState.navigate(to: .intro(step: .second))
            }) {
                Text("下一步")
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
