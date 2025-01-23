import SwiftUI
//
//struct Artwork: Identifiable, Hashable {
//    let id = UUID()
//    let title: String
//    let imageName: String
//    let description: String
//  let number: String // 序号
//    let colors: [Color]
//
//    
//    static func == (lhs: Artwork, rhs: Artwork) -> Bool {
//        lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//// 预定义的艺术作品
//extension Artwork {
//    static let thePotatoEaters = Artwork(
//        title: "The Potato Eaters",
//        imageName: "The_potato_eaters",
//        description: "One of Van Gogh's early masterpieces...",
//        number: "01",
//        colors: [
//            Color(red: 0.09, green: 0.10, blue: 0.09),
//            Color(red: 0.10, green: 0.13, blue: 0.08)
//        ]
//    )
//    
//    static let starryNight = Artwork(
//        title: "The Starry Night",
//        imageName: "Starry_night",
//        description: "Perhaps Van Gogh's most famous work...",
//        number: "02",
//        colors: [
//            Color(red: 0.08, green: 0.40, blue: 0.73),
//            Color(red: 0.97, green: 0.77, blue: 0.37)
//        ]
//    )
//    static let sunflowers = Artwork(
//        title: "Sunflowers",
//        imageName: "Sun_flowers",
//        description: "A series of paintings featuring sunflowers...",
//        number: "03",
//        colors: [Color(red: 0.97, green: 0.77, blue: 0.37)]
//    )
//
//    static let wheatfieldWithCrow = Artwork(
//        title: "Wheatfield with Crow",
//        imageName: "Wheatfield_with_crows",
//        description: "A painting depicting a wheatfield with a crow...",
//        number: "04",
//        colors: [Color(red: 0.97, green: 0.77, blue: 0.37)]
//    )
//    // ... 其他艺术作品
//
//
//}


import Foundation
import SwiftUI

struct Artwork: Identifiable, Hashable {
  let id = UUID()
  let title: String
  let imageName: String
  let description: String
let number: String // 序号
  var paletteInfo: [PaletteInfo]

  var paintingFeatures: String

  var artistQuote: String?
  static func == (lhs: Artwork, rhs: Artwork) -> Bool {
      lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
}

struct PaletteInfo: Equatable,Hashable {
  var colorName: String
  var hue: Double
  var saturation: Double
  var brightness: Double
  var explanation: String
    var color: Color {
      Color(hue: hue / 360, saturation: saturation, brightness: brightness, opacity: 1.0)
    }

  
  static func == (lhs: PaletteInfo, rhs: PaletteInfo) -> Bool {
    return lhs.hue == rhs.hue && lhs.saturation == rhs.saturation && lhs.brightness == rhs.brightness && lhs.explanation == rhs.explanation
  }
}
