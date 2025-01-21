import SwiftUI 

enum ViewFactory {
    // MARK: - View Creation
   @ViewBuilder
static func makeView(for route: Route) -> some View {
    switch route {
    case .welcome:
        makeWelcomeView()
    case .intro(let step):
        makeIntroView(step: step)
    case .home:
        makeHomeView()
    case .workIntro(let artwork):
        makeWorkIntroView(artwork: artwork)
    case .colorStudy(let artwork):
        makeColorStudyView(artwork: artwork)
    case .colorChallenge(let artwork):
        makeColorChallengeView(artwork: artwork)
        }
    }
    
    // MARK: - Private View Factories
    private static func makeWelcomeView() -> some View {
        WelcomeView()
            .transition(.opacity.combined(with: .slide))
            .modifier(PageTransitionModifier())
    }
    
    private static func makeIntroView(step: Route.IntroStep) -> some View {
        Group {
            switch step {
            case .first:
                IntroView1()
            case .second:
                IntroView2()
            }
        }
        .transition(.opacity.combined(with: .slide))
        .modifier(PageTransitionModifier())
    }
    
    private static func makeHomeView() -> some View {
        HomeView()
            .transition(.opacity.combined(with: .slide))
            .modifier(PageTransitionModifier())
    }
    
    private static func makeWorkIntroView(artwork: Artwork) -> some View {
        WorkIntroView(artwork: artwork)
            .transition(.opacity.combined(with: .slide))
            .modifier(PageTransitionModifier())
    }
    
    private static func makeColorStudyView(artwork: Artwork) -> some View {
        ColorStudyView(artwork: artwork)
            .transition(.opacity.combined(with: .slide))
            .modifier(PageTransitionModifier())
    }
    
    private static func makeColorChallengeView(artwork: Artwork) -> some View {
        ColorChallengeView(artwork: artwork)
            .transition(.opacity.combined(with: .slide))
            .modifier(PageTransitionModifier())
    }
}

// MARK: - Transition Modifiers
struct PageTransitionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .animation(.easeInOut, value: true)
    }
}

// MARK: - Navigation Modifiers
extension ViewFactory {
    static func addNavigationDestinations<Content: View>(to content: Content) -> some View {
        content.navigationDestination(for: Route.self) { route in
            makeView(for: route)
        }
    }
}

// MARK: - Common View Modifiers
extension ViewFactory {
    static func applyCommonModifiers<Content: View>(to content: Content) -> some View {
        content
            .preferredColorScheme(.light)
            .environmentObject(AppState())
    }
}

// MARK: - Preview Helpers
extension ViewFactory {
    static func makePreview(for route: Route) -> some View {
        makeView(for: route)
            .environmentObject(AppState())
    }
}