import SwiftUI


struct NextBT: View {
  let color: Color
    let action: () -> Void
  
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text("Next")
                    .serifH0_36()
                  
                    .underline()
                Image(systemName: "arrow.right")
                    .font(.largeTitle)
                   
            }
            .foregroundColor(color)
        }
    }
}
