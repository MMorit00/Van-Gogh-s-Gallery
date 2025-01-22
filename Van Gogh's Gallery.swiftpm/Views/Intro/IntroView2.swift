import SwiftUI

struct IntroView2: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack(spacing: 32) {
            // 标题

            // 上半部分
            HStack(alignment: .top, spacing: 0) {
                // 左侧文本
                VStack(alignment: .leading, spacing: 38) {
                    
                    Text("The Color Revolution: 1886-1890")
                        .serifH1_24_italic()
                        .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.04))
                        .frame(width: 296)

                    Text("Moving to France marked a turning point in Van Gogh's artistic journey. Inspired by the vibrant atmosphere and fellow artists, his palette transformed from dark earth tones to explosive colors.")
                        .roundedH2_16()
                        .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.04))
                }
                .ignoresSafeArea()
                .padding(.trailing,48)
                .padding(.leading,200)
                // 右侧图片
                IntroImage(imageName: "Wheatfield with Crows",
                           width: 544.5,
                           height: 272)
            }
            .ignoresSafeArea()
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
         
            
          

            // 下半部分
            HStack(alignment: .center, spacing: 0) {
                // 左侧图片
                IntroImage(imageName: "Sunflowers",
                           width: 328,
                           height: 404.5)
                        
                .padding(.leading,192)
                .padding(.trailing,106)
              

                // 右侧文本
                VStack(alignment: .center, spacing: 0) {
                  VStack(alignment: .leading, spacing: 12){
                    Text("In his final years, he created masterpieces like \"Sunflowers\" and \"Wheatfield with Crows\". These works, with their bold colors and expressive brushstrokes, would later revolutionize modern art and continue to move audiences worldwide.")
                    Text("Now, let's step into Van Gogh's gallery and explore the power of his revolutionary use of color.")
                      .bold()
                    
                  }
                        .roundedH2_16()
                        .frame(width: 395)
                        .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.04))
                    

                    // Next按钮
                    NextBT(color: Color(red: 0.89, green: 0.79, blue: 0.28)) {
                        // 添加导航动作
                        appState.navigate(to: .home)
                    }
                    .offset(y: 52)
                  
                }
             
            }
            .offset(y:-78)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
        
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
       
       
        .background(Color(red: 0.99, green: 0.98, blue: 0.94))
    }
}

#Preview {
    IntroView2()
}
