import SwiftUI

// MARK: - Constants
private enum Constants {
    static let backgroundColor = Color(hex: "#FCFAF0")
    static let darkBrownColor = Color(hex: "#3F3010")
    static let textColor = Color(hex: "#FAF5ED")
    static let goldColor = Color(hex: "#F7C45E")
    
    static let selfPortraitImage = "Van"
    static let MuseumImage = "Museum photo"
}

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // 上半部分 - 浅色背景
                upperSection(geometry: geometry)
                    .frame(height: geometry.size.height * 0.5)
                    .background(Constants.backgroundColor)
                    .zIndex(5)
                
                // 下半部分 - 深色背景
                lowerSection
                    .frame(height: geometry.size.height * 0.5)
                    .background(Constants.darkBrownColor)
            }
        }
    }
    
    private func upperSection(geometry: GeometryProxy) -> some View {
      VStack(spacing:0){
        Spacer()
        
        HStack(alignment: .center, spacing: 150) {
          // 左侧图片区域
          ZStack {
            
            // 自画像
            IntroImage(
                imageName: Constants.selfPortraitImage,
                width: 299,
                height: 352
            )
            .padding(.leading,112)
        
        
           
            
            // 星空图
            IntroImage(
                imageName: Constants.MuseumImage,
                width: 220.50,
                height: 192
            )
         
            .offset(x: 155, y: 120)
          }
          
          
          // 右侧文字区域
          VStack(alignment: .leading, spacing: 0) {
            Text("Explore Van Gogh's Art World")
              .serifH0_36()
              .foregroundColor(Color(hex: "#3B3307"))
              .padding(.bottom,16)
            Text("Experience the timeless masterpieces of the Post-Impressionist masters")
              .serifH2_16_italic()
              .frame(width: 342)
              .foregroundColor(.black)
              .padding(.bottom,18)
            
            Text("Step into the extraordinary world of Vincent van Gogh (1853-1890), where swirling stars, golden sunflowers, and vibrant landscapes come alive through bold colors and expressive brushstrokes. Discover the masterpieces that revolutionized modern art and continue to captivate audiences worldwide.")
              .frame(width: 342)
              .roundedH3_12()
              .foregroundColor(.black)
              .fixedSize(horizontal: false, vertical: true)
          }
        
        
        }
      }
      .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var lowerSection: some View {
        HStack(alignment: .center, spacing: 40) {
            // 左侧文字
            VStack(alignment: .leading, spacing: 30) {
                Text("Begin Your Color Journey with Vincent van Gogh")
                    .serifH1_24_italic()
                    .foregroundColor(Constants.textColor)
                
                Text("Through his eyes, discover how colors can tell stories. From the vibrant yellows of sunflowers to the dreamy blues of starry nights, each shade carries a piece of Vincent's soul.\n\nReady to explore the world of colors that changed art forever?")
                    .serifH1_24_italic()
                    .foregroundColor(Constants.textColor)
                    .lineSpacing(8)
            }
            .frame(width: 640)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.leading, 120)
            .padding(.trailing,103)
            
            // 右侧按钮
            NextBT(color: Constants.goldColor,action: {
                appState.navigate(to: .intro(step: .first))
            })
           
            
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

// MARK: - Supporting Views

