import SwiftUI

struct ArtworkCard: View {
    let artwork: Artwork
    let imageWidth: CGFloat
    let imageHeight: CGFloat

    init(artwork: Artwork,
         width: CGFloat = 624,
         height: CGFloat = 462)
    {
        self.artwork = artwork
        imageWidth = width
        imageHeight = height
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 序号
            Text("\(artwork.number).")
                .roundedH2_16()
                .underline()
                .foregroundColor(.black)

            // 图片
            IntroImage(imageName: artwork.imageName,
                       width: imageWidth,
                       height: imageHeight)
        }
        .frame(width: imageWidth, height: imageHeight + 35)
    }
}

// 预览
#Preview {
    ArtworkCard(artwork: thePotatoEaters) // 直接使用全局变量
}
