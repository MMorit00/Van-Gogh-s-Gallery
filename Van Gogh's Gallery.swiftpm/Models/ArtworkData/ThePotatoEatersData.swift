/*
 Author: Lingchuan Pan
 Description:The complete data of "thePotatoEaters ", the data is compiled by me through research.
 */

import Foundation
import SwiftUI

let somberBrownPaletteInfo = PaletteInfo(
  colorName: "Dark sepia",
  hue: 84.0,
  saturation: 0.1,
  brightness: 0.1,
  explanation: """
  Dark sepia, evoking the dim light of a simple peasant home, captures the somber mood and the rustic reality of the scene. This hue reflects the harsh living conditions and the frugality of the meal, emphasizing the authenticity and gravity of peasant life. Van Gogh's use of this color underlines his desire to portray the dignity and resilience of the working class.
  """
)

let mutedGreenPaletteInfo = PaletteInfo(
  colorName: "Olive green",
  hue: 83.0,
  saturation: 0.34,
  brightness: 0.12,
  explanation: """
  Olive green, used to depict the worn clothing and sparse interior, symbolizes the connection to the earth and the simplicity of peasant life. This muted hue complements the somber palette, reinforcing the theme of endurance and modesty. Van Gogh's choice of olive green highlights his respect for their humble existence and his aim to convey their story with sincerity.
  """
)

var paletteInfoForThePotatoEaters: [PaletteInfo] = [somberBrownPaletteInfo, mutedGreenPaletteInfo]

let thePotatoEaters = Artwork(
  title: "The Potato Eaters",
  imageName: "The_potato_eaters",
  description: """
  Completed in 1885, "The Potato Eaters" is one of Van Gogh's earliest masterpieces, depicting peasants sharing a humble meal. The dark palette and rough brushwork emphasize the harsh reality of rural life, reflecting Van Gogh's deep empathy for the working class.
  """,
  number: "01",
  paletteInfo: paletteInfoForThePotatoEaters,

  paintingFeatures: """
  "The Potato Eaters" is characterized by its dark tones and the use of shadow, creating a somber atmosphere that is almost palpable. The painting's composition, with its focus on the shared meal and the interaction of the figures, emphasizes the communal aspect of peasant life, while the faces, illuminated by the lamp, become a focal point of shared humanity.
  """,
  artistQuote: """
  "Look, I really wanted to make it so that people would get the idea that these people who eat their potatoes by the light of their little lamp have worked the earth themselves with these hands that they put into the bowl" 
  """
)
