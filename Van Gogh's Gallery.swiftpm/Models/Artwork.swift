import SwiftUI

struct Artwork: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
    let year: String
    let colors: [Color]
    
    static func == (lhs: Artwork, rhs: Artwork) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// 预定义的艺术作品
extension Artwork {
    static let thePotatoEaters = Artwork(
        title: "The Potato Eaters",
        imageName: "potato_eaters",
        description: "One of Van Gogh's early masterpieces...",
        year: "1885",
        colors: [
            Color(red: 0.09, green: 0.10, blue: 0.09),
            Color(red: 0.10, green: 0.13, blue: 0.08)
        ]
    )
    
    static let starryNight = Artwork(
        title: "The Starry Night",
        imageName: "starry_night",
        description: "Perhaps Van Gogh's most famous work...",
        year: "1889",
        colors: [
            Color(red: 0.08, green: 0.40, blue: 0.73),
            Color(red: 0.97, green: 0.77, blue: 0.37)
        ]
    )
    static let sunflowers = Artwork(
        title: "Sunflowers",
        imageName: "sunflowers",
        description: "A series of paintings featuring sunflowers...",
        year: "1888",
        colors: [Color(red: 0.97, green: 0.77, blue: 0.37)]
    )

    static let wheatfieldWithCrow = Artwork(
        title: "Wheatfield with Crow",
        imageName: "wheatfield_with_crow",
        description: "A painting depicting a wheatfield with a crow...",
        year: "1889",
        colors: [Color(red: 0.97, green: 0.77, blue: 0.37)]
    )
    // ... 其他艺术作品


}
