
import SwiftUI  

struct MainCoordinator: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.navigationPath) {
            ViewFactory.makeView(for: .welcome)
                .navigationDestination(for: Route.self) { route in
                    ViewFactory.makeView(for: route)
                }
        }
        .environmentObject(appState)
    }
}