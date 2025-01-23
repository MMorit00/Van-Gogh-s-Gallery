import SwiftUI

struct MainCoordinator: View {
    @StateObject private var appState = AppState()

    var body: some View {
        ZStack {
            switch appState.currentRoute {
            case .welcome:
                ViewFactory.makeView(for: .welcome)
            case let .intro(step):
                ViewFactory.makeView(for: .intro(step: step))
            case .home:
                ViewFactory.makeView(for: .home)
            case let .workIntro(artwork):
                ViewFactory.makeView(for: .workIntro(artwork: artwork))
            case let .colorStudy(artwork):
                ViewFactory.makeView(for: .colorStudy(artwork: artwork))
            case let .colorChallenge(artwork):
                ViewFactory.makeView(for: .colorChallenge(artwork: artwork))
            }
        }
        .environmentObject(appState)
        .transition(.opacity)
    }
}
