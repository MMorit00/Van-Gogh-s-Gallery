import SwiftUI

struct IntroImage: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image(imageName)
         
            .resizable()
          
            .aspectRatio(contentMode: .fill)
         
            .frame(width: width, height: height)
         
           
    
    }
}
