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
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        
                        .stroke(.white, lineWidth: 3.5)
                )

            Text(title)
                .roundedH2_16()
        }
        .frame(width: 160)
        .onTapGesture(perform: action)
    }
}
