import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinator()
                .preferredColorScheme(.light)
//          CongrPopup(onNextTapped: {})
//            ColorChallengeView(artWork: thePotatoEaters)
//          ColorStudyView(artwork: thePotatoEaters)
//            .environmentObject(AppState())
        }
    }
}
