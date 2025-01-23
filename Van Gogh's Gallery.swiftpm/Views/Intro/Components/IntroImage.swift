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
            .cornerRadius(2)
//            .shadow(color: .black.opacity(0.25), radius: 5, y: 2)
            .padding(0)
            .contentShape(Rectangle())
    }
}
