import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    // 使用appState中的selectedArtwork
    private var selectedArtwork: Binding<Artwork> {
        Binding(
            get: { appState.selectedArtwork ?? appState.artworks[0] },
            set: { appState.selectedArtwork = $0 }
        )
    }

  var body: some View {
    ZStack{
      VStack(spacing: 0){
        Rectangle()
        .fill(Color(hex: "#EEF3F9"))
        .frame(height: UIScreen.main.bounds.height * 0.5)
        Rectangle()
        .fill(Color(hex: "#162D42"))
        .frame(height: UIScreen.main.bounds.height * 0.5)
      }
      VStack(spacing: 0) {
        // 标题
        Text("Explore the Colors of Van Gogh")
          .serifH1_24()
          .padding(.top,44)
          .padding(.bottom,46)
        
        // 画廊
        ArtworkGallery(
          artworks: appState.artworks,
          selectedArtwork: selectedArtwork
        )
        
        // 作品标题
        Text(selectedArtwork.wrappedValue.title)
          .serifH1_24()
          .foregroundColor(.white)
          
        
        // 底部提示文本
        Text("Please try clicking on the artwork you want to learn about, and enter the learning of the artwork.")
          .roundedH2_16()
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 40)
          .padding(.bottom, 54)
          .padding(.top,82)
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    
    }
  }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
