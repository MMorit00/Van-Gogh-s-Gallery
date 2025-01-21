import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("梵高画廊")
                .font(.largeTitle)
                .bold()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(appState.artworks, id: \.id) { artwork in
                        ArtworkCard(artwork: artwork)
                            .onTapGesture {
                                appState.navigate(to: .workIntro(artwork: artwork))
                            }
                    }
                }
                .padding()
            }
        }
    }
}

struct ArtworkCard: View {
    let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading) {
            Text(artwork.title)
                .font(.headline)
            Text(artwork.year)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
