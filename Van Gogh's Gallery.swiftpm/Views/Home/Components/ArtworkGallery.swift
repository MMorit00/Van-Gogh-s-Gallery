import SwiftUI

struct ArtworkGallery: View {
    let artworks: [Artwork]
    @Binding var selectedArtwork: Artwork
    @EnvironmentObject var appState: AppState
    @State private var currentIndex: Int = 0
    @State private var offset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let cardWidth: CGFloat = 624
            let spacing: CGFloat = 40
            let cardSize = cardWidth + spacing

            VStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(Array(artworks.enumerated()), id: \.element.id) { index, artwork in
                            ArtworkCard(artwork: artwork)
                                .offset(y: calculateVerticalOffset(
                                    for: index,
                                    cardWidth: cardWidth,
                                    spacing: spacing
                                ))
                                .onTapGesture {
                                  
                                    appState.navigate(to: .workIntro(artwork: artwork))
                                }
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - cardWidth) / 2)
                }
                .content
                .offset(x: offset + dragOffset)
                
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { _ in
                            let totalOffset = offset + dragOffset
                            let newIndex = -Int(round(totalOffset / cardSize))
                            let clampedIndex = max(0, min(newIndex, artworks.count - 1))

                            currentIndex = clampedIndex

                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                offset = -CGFloat(currentIndex) * cardSize
                                dragOffset = 0
                                selectedArtwork = artworks[currentIndex]
                            }
                        }
                )
              
            

            }
//            .overlay(content: {
//              Text(selectedArtwork.title)
//                  .serifH1_24()
//                  .foregroundColor(.blue)
//                  .padding(.top, 20)
//            })
            .onAppear {
                offset = -CGFloat(currentIndex) * cardSize
            }
          
        
        }
    }

    private func calculateVerticalOffset(for index: Int, cardWidth: CGFloat, spacing: CGFloat) -> CGFloat {
        let cardSize = cardWidth + spacing
        let currentPosition = -(offset + dragOffset) / cardSize
        let distance = abs(CGFloat(index) - currentPosition)
        let maxOffset: CGFloat = 60

        let offsetMultiplier = min(distance, 1.0)
        return maxOffset * offsetMultiplier
    }
}

#Preview {
    ArtworkGallery(
        artworks: [thePotatoEaters],
        selectedArtwork: .constant(thePotatoEaters)
    )
}
