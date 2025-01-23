import SwiftUI

class AppState: ObservableObject {
    // MARK: - Navigation State

    @Published var currentRoute: Route = .welcome

    // MARK: - Game Progress State

    @Published var completedArtworks: Set<UUID> = []
    @Published var currentProgress: GameProgress?

    // MARK: - Game Data

    @Published var artworks: [Artwork]

    // MARK: - Color State

    @Published var currentColorScheme: ArtworkColorScheme = .default
    private let colorManager = ArtworkColorManager()

    init() {
        // 直接使用全局变量初始化
        artworks = [
            thePotatoEaters,
            starryNight,
            sunflowers,
            wheatfieldWithCrows,
        ]
        selectedArtwork = artworks[0]
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
            currentRoute = route

            // 如果进入新的艺术品学习，初始化进度
            if case let .workIntro(artwork) = route {
                initializeProgress(for: artwork)
            }

            // 更新颜色方案
            if case let .workIntro(artwork) = route {
                selectedArtwork = artwork
            }
        }
    }

    // 简化导航方法
    func navigateBack() {
        withAnimation(.easeInOut) {
            switch currentRoute {
            case let .colorChallenge(artwork):
                currentRoute = .colorStudy(artwork: artwork)
            case let .colorStudy(artwork):
                currentRoute = .workIntro(artwork: artwork)
            case .workIntro:
                currentRoute = .home
            default:
                currentRoute = .welcome
            }
        }
    }

    func navigateToRoot() {
        withAnimation(.easeInOut) {
            currentRoute = .welcome
            currentProgress = nil
        }
    }

    // 添加直接返回画廊的方法
    func navigateToHome() {
        withAnimation(.easeInOut) {
            currentRoute = .home
            currentProgress = nil
        }
    }

    // MARK: - Progress Management

    func initializeProgress(for artwork: Artwork) {
        selectedArtwork = artwork
        currentProgress = GameProgress(
            colorStudyTotal: artwork.paletteInfo.count,
            challengeTotal: artwork.paletteInfo.count
        )
        print("Progress initialized: total colors = \(artwork.paletteInfo.count)")
    }

    func updateColorStudyProgress() {
        guard var progress = currentProgress else {
            print("Error: Progress not initialized")
            return
        }
        progress.colorStudyProgress += 1
        currentProgress = progress
        print("Progress updated: \(progress.colorStudyProgress)/\(progress.colorStudyTotal)")

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

    // MARK: - Color Management

    private func updateColorScheme() {
        guard let artwork = selectedArtwork,
              let image = UIImage(named: artwork.imageName)
        else {
            currentColorScheme = .default
            return
        }

        Task {
            do {
                let newScheme = try await colorManager.generateColorScheme(from: image)
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.currentColorScheme = newScheme
                    }
                }
            } catch {
                print("Color scheme generation failed: \(error)")
                await MainActor.run {
                    self.currentColorScheme = .default
                }
            }
        }
    }

    @Published var selectedArtwork: Artwork? {
        didSet {
            if selectedArtwork != oldValue {
                updateColorScheme()
            }
        }
    }
}
