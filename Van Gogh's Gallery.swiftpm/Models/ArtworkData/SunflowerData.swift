//

/*
 Author: Lingchuan Pan
 Description:The complete data of "sunflowers ", the data is compiled by me through research.
 */

import Foundation
import SwiftUI

let brightYellowPaletteInfo = PaletteInfo(
  colorName: "Bright khaki color",
  hue: 56.0,
  saturation: 0.86,
  brightness: 0.90,
  explanation: """
  This bright khaki color, symbolic of warmth and joy, captures the essence of the sunflowers in Van Gogh's Sunflowers. Its high saturation and brightness reflect Van Gogh's fascination with light and his ability to convey emotion through color. The hue embodies vitality and the artist's passion for life, resonating with his quest for meaning amidst hardships.
  """
)
let witheredYellowPaletteInfo = PaletteInfo(
  colorName: "Khaki color",
  hue: 44.0,
  saturation: 0.535,
  brightness: 0.396,
  explanation: """
  The khaki color, with its subdued hue, saturation, and brightness, effectively captures the essence of the withering aspect of the sunflowers and the understated backdrop of Van Gogh's painting. This color choice emphasizes the natural cycle of growth and decay, mirroring the transient beauty of life and the stark reality of its fleeting nature. Through the strategic application of this muted yet profound color, Van Gogh invites viewers to reflect on the themes of impermanence and the enduring spirit of resilience in the face of life's ephemeral moments. The painting, thus, becomes a poignant meditation on the inevitable passage of time, encapsulating the delicate interplay between life's vibrant exuberance and its gentle decline, all conveyed through the lens of the withered khaki hues.
  """
)
let greenStemPaletteInfo = PaletteInfo(
  colorName: "Sap green",
  hue: 84.0,
  saturation: 0.425,
  brightness: 0.457,
  explanation: """
  Sap green, representing the stems and leaves of the sunflowers, brings a natural and grounding element to the composition. This color harmonizes with the vibrant yellows, highlighting the contrast between the sunflowers' energetic blooms and their supportive, yet subdued, foliage. Van Gogh's use of this hue emphasizes the balance between strength and vulnerability in life.
  """
)

var paletteInfoForSunflowers: [PaletteInfo] = [witheredYellowPaletteInfo, brightYellowPaletteInfo, greenStemPaletteInfo]

let sunflowers = Artwork(
  title: "Sunflowers",
  imageName: "Sun_flowers",
  description: """
  "Sunflowers" is part of a series created by Van Gogh in 1888, showcasing his masterful use of color and texture to capture the beauty of these flowers. The painting demonstrates his innovative techniques and deep emotional connection to his subjects.
  """,
  number: "03",
  paletteInfo: paletteInfoForSunflowers,

  paintingFeatures: """
  "Sunflowers" is celebrated for its vivid color palette, with varying shades of yellow and gold capturing the lifecycle of sunflowers. Van Gogh's expressive brushwork and the thick application of paint add a tactile quality to the work, emphasizing the flowers' vibrant energy and the painting's emotional depth.
  """,
  artistQuote: """
  "The beginning is perhaps more difficult than anything else, but keep heart, it will turn out all right."
  """
)
