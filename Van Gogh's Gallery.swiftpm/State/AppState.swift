import SwiftUI 

class AppState: ObservableObject {
    // MARK: - Navigation State
    @Published var currentRoute: Route = .welcome
    @Published var navigationPath = NavigationPath()
    
    // MARK: - Game Progress State
    @Published var selectedArtwork: Artwork?
    @Published var completedArtworks: Set<UUID> = []
    @Published var currentProgress: GameProgress?
    
    // MARK: - Game Data
    @Published var artworks: [Artwork]
    
    init() {
        self.artworks = [
            .thePotatoEaters,
            .starryNight,
            .sunflowers,
            .wheatfieldWithCrow
        ]
        self.selectedArtwork = self.artworks[0]
    }
    
    // MARK: - Progress Tracking
    struct GameProgress {
        var colorStudyProgress: Int = 0
        var colorStudyTotal: Int
        var challengeProgress: Int = 0
        var challengeTotal: Int
        
        var isColorStudyComplete: Bool {
            colorStudyProgress == colorStudyTotal
        }
        
        var isChallengeComplete: Bool {
            challengeProgress == challengeTotal
        }
        
        var isComplete: Bool {
            isColorStudyComplete && isChallengeComplete
        }
        
        // 计算学习进度百分比
        var colorStudyPercentage: Double {
            Double(colorStudyProgress) / Double(colorStudyTotal)
        }
        
        // 计算挑战进度百分比
        var challengePercentage: Double {
            Double(challengeProgress) / Double(challengeTotal)
        }
    }
    
    // MARK: - Navigation Methods
    func navigate(to route: Route) {
        withAnimation(.easeInOut) {
            navigationPath.append(route)
            currentRoute = route
            
            // 如果进入新的艺术品学习，初始化进度
            if case .workIntro(let artwork) = route {
                initializeProgress(for: artwork)
            }
        }
    }
    
    // 直接简化为返回欢迎页面
    func navigateBack() {
        withAnimation(.easeInOut) {
            navigationPath.removeLast()
            currentRoute = .welcome
        }
    }

    func navigateToRoot() {
        withAnimation(.easeInOut) {
            navigationPath.removeLast(navigationPath.count)
            currentRoute = .welcome
            currentProgress = nil
        }
    }
    
    // MARK: - Progress Management
    private func initializeProgress(for artwork: Artwork) {
        selectedArtwork = artwork
        currentProgress = GameProgress(
            colorStudyTotal: artwork.colors.count,
            challengeTotal: artwork.colors.count
        )
    }
    
    func updateColorStudyProgress() {
        guard var progress = currentProgress else { return }
        progress.colorStudyProgress += 1
        currentProgress = progress
        
        checkArtworkCompletion()
    }
    
    func updateChallengeProgress() {
        guard var progress = currentProgress else { return }
        progress.challengeProgress += 1
        currentProgress = progress
        
        checkArtworkCompletion()
    }
    
    private func checkArtworkCompletion() {
        guard let artwork = selectedArtwork,
              let progress = currentProgress,
              progress.isComplete else { return }
        
        completedArtworks.insert(artwork.id)
    }
    
    // MARK: - Game State Queries
    func isArtworkCompleted(_ artwork: Artwork) -> Bool {
        completedArtworks.contains(artwork.id)
    }
    
    func isAllArtworksCompleted() -> Bool {
        completedArtworks.count == artworks.count
    }
    
    // MARK: - Progress Display
    func shouldShowProgressBar(for route: Route) -> Bool {
        switch route {
        case .colorStudy, .colorChallenge:
            return true
        default:
            return false
        }
    }
    
    func getCurrentProgressPercentage() -> Double? {
        guard let progress = currentProgress else { return nil }
        
        switch currentRoute {
        case .colorStudy:
            return progress.colorStudyPercentage
        case .colorChallenge:
            return progress.challengePercentage
        default:
            return nil
        }
    }
}
