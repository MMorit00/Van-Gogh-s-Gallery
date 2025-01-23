import SwiftUI

struct ArtworkGallery: View {
    let artworks: [Artwork]
    @Binding var selectedArtwork: Artwork
    @EnvironmentObject var appState: AppState
    @State private var currentIndex: Int = 0
    @State private var offset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging: Bool = false

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
                                .scaleEffect(calculateScale(for: index))
                                .onTapGesture {
                                    appState.navigate(to: .workIntro(artwork: artwork))
                                }
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - cardWidth) / 2)
                }
                .content
                .offset(x: offset + dragOffset)
                .animation(isDragging ?
                    .spring(response: 0.7, dampingFraction: 0.9) :
                    .spring(response: 0.8, dampingFraction: 0.95, blendDuration: 0.8),
                    value: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            dragOffset = value.translation.width * 0.8
                        }
                        .onEnded { value in
                            isDragging = false
                            let totalOffset = offset + dragOffset
                            let velocity = value.predictedEndLocation.x - value.location.x

                            var newIndex = -Int(round(totalOffset / cardSize))
                            if abs(velocity) > 200 {
                                newIndex += velocity > 0 ? -1 : 1
                            }

                            let clampedIndex = max(0, min(newIndex, artworks.count - 1))
                            currentIndex = clampedIndex

                            withAnimation(.spring(
                                response: 0.8,
                                dampingFraction: 0.95,
                                blendDuration: 0.8
                            )) {
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

  private func calculateScale(for index: Int) -> CGFloat {
        let cardSize: CGFloat = 624 + 40  // 添加CGFloat类型
        let currentPosition = -(offset + dragOffset) / cardSize
        let distance = abs(CGFloat(index) - currentPosition)  // 将index转换为CGFloat
        let minScale: CGFloat = 0.95
        
        return 1.0 - (distance * (1.0 - minScale))
    }
}

#Preview {
    ArtworkGallery(
        artworks: [thePotatoEaters],
        selectedArtwork: .constant(thePotatoEaters)
    )
}
