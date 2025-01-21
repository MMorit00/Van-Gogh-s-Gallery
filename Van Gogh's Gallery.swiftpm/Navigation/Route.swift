
import Foundation
 

enum Route: Hashable {
    case welcome
    case intro(step: IntroStep)
    case home
    case workIntro(artwork: Artwork)
    case colorStudy(artwork: Artwork)
    case colorChallenge(artwork: Artwork)
    
    enum IntroStep: Int {
        case first
        case second
    }
}