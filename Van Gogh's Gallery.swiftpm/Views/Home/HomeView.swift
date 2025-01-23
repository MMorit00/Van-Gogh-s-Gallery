import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    // 添加动画状态变量
    @State private var showTitle: Bool = false
    @State private var showGallery: Bool = false
    @State private var showBottomContent: Bool = false
    
    // 使用appState中的selectedArtwork
    private var selectedArtwork: Binding<Artwork> {
        Binding(
            get: { appState.selectedArtwork ?? appState.artworks[0] },
            set: { appState.selectedArtwork = $0 }
        )
    }
    
    private func getTextTransition(_ index: Int) -> AnyTransition {
        .asymmetric(
            insertion: .opacity
                .combined(with: .move(edge: .bottom))
                .combined(with: .scale(scale: 0.8))
                .animation(.easeInOut(duration: 0.6).delay(Double(index) * 0.2)),
            removal: .opacity.animation(.easeInOut(duration: 0.3))
        )
    }
    
    var body: some View {
        ZStack {
            // 背景颜色
            VStack(spacing: 0) {
                Rectangle()
                    .fill(appState.currentColorScheme.upperBackground)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                Rectangle()
                    .fill(appState.currentColorScheme.lowerBackground)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
            }
            .animation(.easeInOut(duration: 0.3), value: appState.currentColorScheme)
            
            VStack(spacing: 0) {
                // 标题
                if showTitle {
                    Text("Explore the Colors of Van Gogh")
                        .serifH1_24()
                        .foregroundColor(.black)
                        .padding(.top, 44)
                        .padding(.bottom, 46)
                        .transition(getTextTransition(0))
                }
                
                // 画廊
                if showGallery {
                    ArtworkGallery(
                        artworks: appState.artworks,
                        selectedArtwork: selectedArtwork
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    
                    // 作品标题
                    Text(selectedArtwork.wrappedValue.title)
                        .serifH1_24()
                        .foregroundColor(appState.currentColorScheme.upperBackground)
                        .transition(.opacity)
                }
                
                // 底部提示文本
                if showBottomContent {
                    Text("Please try clicking on the artwork you want to learn about, and enter the learning of the artwork.")
                        .roundedH2_16()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 54)
                        .padding(.top, 82)
                        .transition(getTextTransition(1))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            // 触发入场动画序列
            withAnimation(.easeOut(duration: 0.6)) {
                showTitle = true
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                showGallery = true
            }
            
            withAnimation(.easeOut(duration: 0.6).delay(0.6)) {
                showBottomContent = true
            }
        }
    }
}

#Preview {
  HomeView()
    .environmentObject(AppState())
}
