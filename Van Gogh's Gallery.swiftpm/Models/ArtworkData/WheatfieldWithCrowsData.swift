

/*
 Author: Lingchuan Pan
 Description:The complete data of "wheatfieldWithCrows", the data is compiled by me through research.
 */

import Foundation
import SwiftUI

let turbulentSkyPaletteInfo = PaletteInfo(
  colorName: "Stormy blue",
  hue: 210.0,
  saturation: 0.60,
  brightness: 0.40,
  explanation: """
  Stormy blue captures the tumultuous emotions and the intense energy of the sky in "Wheatfield with Crows". This hue reflects the depth of Van Gogh's emotional state during the painting's creation, symbolizing turmoil and perhaps the artist's internal struggles. The choice of this color enhances the painting's dramatic effect, inviting viewers to ponder the story behind the canvas.
  """
)

let goldenWheatPaletteInfo = PaletteInfo(
  colorName: "Golden yellow",
  hue: 52.0,
  saturation: 0.88,
  brightness: 0.60,
  explanation: """
  Golden yellow, representing the ripe wheat field, contrasts vividly with the stormy sky, embodying hope and nature's bounty. This bright, warm hue symbolizes life's vitality and the enduring cycle of growth and harvest. Van Gogh's use of golden yellow in this context may reflect his search for peace amidst personal turmoil.
  """
)

let ominousCrowsPaletteInfo = PaletteInfo(
  colorName: "Deep black",
  hue: 70.0,
  saturation: 0.25,
  brightness: 0.094,
  explanation: """
  Deep black, used to depict the crows over the wheat field, adds a sense of foreboding and mystery to the scene. The crows, often associated with omens or transition, contribute to the painting's complex symbolism, suggesting themes of mortality, hope, and the unknown. Van Gogh's inclusion of these enigmatic figures invites various interpretations, enriching the artwork's narrative depth.
  """
)
let deepGreenPaletteInfo = PaletteInfo(
  colorName: "Dark olive green",
  hue: 78.75,
  saturation: 0.267,
  brightness: 0.353,
  explanation: """
  Dark olive green, capturing the vitality of nature, symbolizes renewal and growth. This shade reflects the lushness of the landscape, embodying hope and the rejuvenating power of the natural world. Its moderate saturation and brightness evoke a sense of calm and balance, highlighting the beauty of the environment. The use of Fresh Green in the artwork emphasizes the artist's connection to nature and their appreciation for its endless cycles and transformations.
  """
)

let earthyDepthPaletteInfo = PaletteInfo(
  colorName: "Squid ink color",
  hue: 30.0,
  saturation: 0.80,
  brightness: 0.38,
  explanation: """
  Squid ink color, with its deep and intense coloration, symbolizes the grounding force of nature and the profound connection between life and the earth. This color, through its robust hue, high saturation, and moderated brightness, conveys the richness of the earth that sustains growth and harbors life's roots. In the context of Van Gogh's work, it may also represent the deep, often unspoken, emotions and struggles that lie beneath the surface of existence. The use of Rich Soil in the artwork can highlight themes of fertility, growth, decay, and the cyclical nature of life, reflecting the artist's fascination with the natural world and his contemplation of the human condition.
  """
)

var paletteInfoForWheatfieldWithCrows: [PaletteInfo] = [turbulentSkyPaletteInfo, goldenWheatPaletteInfo, ominousCrowsPaletteInfo, deepGreenPaletteInfo, earthyDepthPaletteInfo]

let wheatfieldWithCrows = Artwork(
  title: "Wheatfield with Crows",
  imageName: "Wheatfield_with_crows",
  description: """
  "Wheatfield with Crows", painted in July 1890, is one of Vincent van Gogh's most powerful and emotive works, possibly reflecting his intense feelings of isolation and tumult in the final days of his life. This painting, with its vibrant colors and dynamic composition, captures a moment of profound beauty and underlying tension.
  """,
  number: "04",
  paletteInfo: paletteInfoForWheatfieldWithCrows,

  paintingFeatures: """
  The painting is notable for its dramatic, swirling sky, the vibrantly colored wheatfield, and the flight of crows that cut through the scene, possibly symbolizing the conflict between tranquility and turmoil. Van Gogh's expressive brushwork and the use of contrasting colors create a scene that is at once captivating and unsettling.
  """,
  artistQuote: """
  "But then the time comes when migratory birds fly away. A fit of melancholy - he's got everything he needs, say the children who look after him - but the sky is brooding and stormy, and deep within he is rebelling against his misfortune." 
  """
)
