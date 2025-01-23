/*
 Author: Lingchuan Pan
 Description:The complete data of "starryNight", the data is compiled by me through research.
 */

import Foundation
import SwiftUI

let deepBluePaletteInfo = PaletteInfo(
  colorName: "Ultramarine artificial",
  hue: 223.0,
  saturation: 0.41,
  brightness: 0.38,
  explanation: """
  This deep blue, akin to the endless expanse of the universe, captures the enigmatic essence of the night sky in The Starry Night. Its moderate saturation and brightness evoke a profound sense of mystery and introspection, mirroring Van Gogh's emotional depth and contemplation during his time at Saint-Rémy-de-Provence. This hue embodies the infinite, highlighting the contrast between the celestial and the earthly.
  """
)

let vibrantYellowPaletteInfo = PaletteInfo(
  colorName: "Yellow ochre",
  hue: 36.0,
  saturation: 0.77,
  brightness: 0.56,
  explanation: """
  The vibrant yellow, reminiscent of the glowing stars and moon against the night's canvas, serves as a beacon of hope and illumination. Van Gogh's choice of this radiant hue reflects his enduring fascination with celestial bodies and his quest to capture their ethereal light. The juxtaposition of this yellow against the deep blues creates a vivid contrast, symbolizing the flicker of optimism amidst the shadows of despair.
  """
)

let greenCoverPaletteInfo = PaletteInfo(
  colorName: "Emerald green",
  hue: 69.0,
  saturation: 0.41,
  brightness: 0.37,
  explanation: """
  Emerald green, emblematic of renewal and the vitality of nature, infuses The Starry Night with a sense of growth and life's endless cycle. This hue, with its balanced brightness and saturation, mirrors the tranquil harmony of natural landscapes, offering a counterpoint to the dynamic celestial elements above. Van Gogh's use of this color underscores his deep connection to the natural world and his aspiration to encapsulate its vibrant spirit.
  """
)

let brownTreePaletteInfo = PaletteInfo(
  colorName: "Burnt umber",
  hue: 34.0,
  saturation: 0.49,
  brightness: 0.09,
  explanation: """
  Burnt umber, used to depict the solitary cypress, anchors the foreground with its somber hue, offering a stark contrast to the luminous sky. This color choice embodies the profound solitude and existential musings that Van Gogh experienced, serving as a metaphor for life's darker aspects. The cypress, often a symbol of mourning, underscores Van Gogh's preoccupation with mortality and the transcendental, bridging the earthly with the ethereal.
  """
)

var paletteInfoForStarryNight: [PaletteInfo] = [deepBluePaletteInfo, vibrantYellowPaletteInfo, greenCoverPaletteInfo, brownTreePaletteInfo]

let starryNight = Artwork(
  title: "The Starry Night",
  imageName: "Starry_night",
  description: """
  Created in June 1889, "The Starry Night" depicts a night scene of swirling clouds, brilliant stars, and a crescent moon over a sleeping village, painted from Van Gogh's asylum room window. The work showcases his unique style of expressive brushwork and vibrant colors.
  """,
  number: "02",
  paletteInfo: paletteInfoForStarryNight,

  paintingFeatures: """
  "The Starry Night" is acclaimed for its compelling night sky, marked by swirling clouds, radiant stars, and a bright crescent moon, rendered with thick, expressive impasto brushstrokes. This dynamic texture, combined with stark contrasts between the serene village and the agitated heavens, vividly conveys van Gogh's inner turmoil and his quest for hope amidst despair.
  """,
  artistQuote: """
  "Looking at the stars always makes me dream..." 
  """
)
