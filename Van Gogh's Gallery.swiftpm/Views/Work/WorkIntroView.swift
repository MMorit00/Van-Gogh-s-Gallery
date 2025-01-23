import SwiftUI

extension Color {
    static let theme = ThemeColors()
}

struct ThemeColors {
    // 背景色
    let darkBackground = Color(red: 0.16, green: 0.18, blue: 0.14)
    let lightBackground = Color(red: 0.90, green: 0.92, blue: 0.88)

    // 画作特征色
    let darkSepia = Color(red: 0.09, green: 0.10, blue: 0.09)
    let oliveGreen = Color(red: 0.10, green: 0.13, blue: 0.08)

    // 文字颜色
    let lightText = Color(red: 0.90, green: 0.92, blue: 0.88)
    let darkText = Color.black

    // 边框颜色
    let border = Color.white
}

struct WorkIntroView: View {
    let artwork: Artwork

    var body: some View {
      ZStack{
        HStack{
          Rectangle()
            .fill(Color.theme.darkBackground)
            .ignoresSafeArea()
          Rectangle()
            .fill(Color.theme.lightBackground)
            .ignoresSafeArea()
        }
        
        GeometryReader { geometry in
          HStack(spacing: 0) {
            // 左侧深色区域
            VStack(alignment: .leading, spacing: 0) {
              // 主图
              IntroImage(
                imageName: "The_potato_eaters",
                width:  671.5,
                height: 456
              )
              .padding(.top,24 + 18)
              .padding(.bottom,16)
              .offset(x:-24)
              .zIndex(20)
              
              
              VStack(alignment: .leading, spacing: 6) {
                // 引用文字
                Text("\"Look, I really wanted to make it so that people would get the idea that these people who eat their potatoes by the light of their little lamp have worked the earth themselves with these hands that they put into the bowl\"")
                  .serifH3_12_italic()
                  .frame(width: 392)
                Text("- Vincent van Gogh")
                  .serifH3_12_italic()
              }
              .padding(.leading,96)
              
              .foregroundColor(Color.theme.lightText)
              
              // 底部描述
              VStack(alignment:.leading,spacing: 20) {
                Text("Painting Features")
                  .serifH0_36()
                  .foregroundColor(Color.theme.lightText)
                  .padding(.top,40)
                Text("The Potato Laters is characterized by its dark tones and the use of shadow, creating a somber atmosphere that is almost palpable. The painting's composition, with its focus on the shared meal and the interaction of the figures, emphasizes the communal aspect of peasant life, while the faces illuminated by the lamp, become a focal point of shared humanity.")
                  .roundedH3_12()
                  .frame(width: 430)
              
                  .foregroundColor(Color.theme.lightText)
              }
              .padding(.leading,56)
              Spacer()
            
            }
            .zIndex(10)
            .ignoresSafeArea()
         
            
            // 右侧浅色区域
            VStack(spacing: 40) {
              // 介绍文本
              VStack(alignment: .leading) {
                Text("Intro")
                  .serifH0_36()
                  .foregroundColor(Color.theme.darkText)
                  .padding(.bottom,32)
                Text("Completed in 1885, \"The Potato Eaters\" marks one of Vincent van Gogh's first major works, depicting the harsh reality of peasant life. This painting was a deliberate effort by Van Gogh to capture the authenticity and somberness of the rural lifestyle, away from the romanticized visions common in art. Van Gogh considered this work as a milestone in his quest to convey truth and emotion through his art.")
                  .roundedH3_12()
                  .padding(.trailing,121)
                 .fixedSize(horizontal: false, vertical: true)
                  .foregroundColor(Color.theme.darkText)
               
              }
              
              // 颜色部分
              VStack(alignment: .leading,spacing: 0) {
                Text("Color")
                  .serifH0_36()
                  .foregroundColor(Color.theme.darkText)
                  .padding(.bottom,32)
                HStack(spacing: 32) {
                  ColorBlock(
                    color: Color.theme.darkSepia,
                    title: "Dark sepia"
                  ) {
                    // 处理点击
                  }
                  
                  ColorBlock(
                    color: Color.theme.oliveGreen,
                    title: "Olive green"
                  ) {
                    // 处理点击
                  }
                }
              }
              .frame(maxWidth: .infinity,alignment: .leading)
              
              Spacer()
              
              // 底部按钮
              Button(action: {}) {
                Text("Let's Dive in")
                  .serifH0_36()
                  .foregroundColor(Color.theme.lightText)
              
                  .padding(.horizontal,88)
                  .padding(.vertical, 28)
                  .background(Color.theme.darkBackground)
                 
             
              }
              .frame(maxWidth: .infinity,alignment: .leading)
            }
            .zIndex(1)
            .padding(.vertical, 54)
          
          }
        }
      }
    }
}

#Preview {
    WorkIntroView(artwork: Artwork.thePotatoEaters)
}
