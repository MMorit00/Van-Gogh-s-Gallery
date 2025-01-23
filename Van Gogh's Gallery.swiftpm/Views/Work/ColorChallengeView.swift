import SwiftUI

struct ColorChallengeView: View {
    @State private var selectedColor = Color(red: 0.51, green: 0.50, blue: 0.50) // 默认灰色
    let artWork: Artwork
    // 抽取颜色为常量
    private let backgroundColor = Color(red: 0.90, green: 0.92, blue: 0.88)
    private let targetColor = Color(red: 0.28, green: 0.33, blue: 0.29)

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("Color Challenge")
                    .serifH0_36()
                    .padding(.top,48)

                // Color blocks container
                ZStack(alignment: .center) {
                    VStack(spacing: 0) {
                        // Target color block
                        Rectangle()
                            .fill(targetColor)
                            .frame(maxWidth: .infinity)
                         
                            .overlay(
                                Text("Try to match the color you choose with the target color")
                                    .serifH2_16_italic()
                                    .foregroundColor(backgroundColor)
                                    .padding()
                            )
                            .cornerRadius(12, corners: [.topLeft, .topRight])
                        
                        // Your color block
                        Rectangle()
                            .fill(selectedColor)
                      
                            .frame(maxWidth: .infinity)
                        
                         
                            .overlay(
                                Text("Your Color")
                                    .serifH2_16_italic()
                                    .foregroundColor(backgroundColor)
                                    .padding()
                            )
                            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal,240)
                    .padding(.vertical,50)
                    
                  
              
                    
                    // Color Picker overlay
                    ColorPicker("", selection: $selectedColor)
                        .labelsHidden()
                        .scaleEffect(1.5)
                        
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 44, height: 44)
                        )
                }
                .shadow(color: .black.opacity(0.25), radius: 5, y: 2)

                Spacer()

                // Progress bar section
                VStack(spacing: 16) {
                    ProgressBar(progress: 0.32)
                        .frame(height: 15.5)

                    Text("If the color challenge is successful(progress bar is 100%), it will automatically return to the gallery.")
                        .roundedH2_16()
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom,40)
            }
        
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
        }
    }
}

// 添加圆角辅助扩展
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ColorChallengeView(artWork: Artwork.thePotatoEaters)
}
