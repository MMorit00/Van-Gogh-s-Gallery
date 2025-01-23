import SwiftUI


struct ColorBlock: View {
    let color: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 96.5)
                .background(color)
                .overlay(
                    Rectangle()
                        .inset(by: 1.5)
                        .stroke(.white, lineWidth: 2.5)
                )
            
            Text(title)
                .roundedH2_16() // 使用Typography系统
        }
        .frame(width: 160)
        .onTapGesture(perform: action)
    }
}
