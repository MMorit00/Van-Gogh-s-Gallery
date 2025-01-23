import SwiftUI

struct ColorInfoSheetView: View {
  let color: Color
  let title: String
  let hue: Double
  let saturation: Double
  let brightness: Double
  let explanation: String
  @EnvironmentObject var appState: AppState

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.system(.title, design: .rounded).bold())
        .foregroundColor(appState.currentColorScheme.lowerBackground)
        .padding(.bottom, 10)

      HStack(spacing: 20) {
        color

          .frame(width: 150, height: 150)
          .clipShape(Circle())
          .shadow(radius: 5)
          .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
          .padding(.bottom, 10)
          .padding(.trailing, 100)

        VStack(alignment: .leading, spacing: 12) {
          HStack(spacing: 8) {
            Image(systemName: "paintpalette.fill")
              .foregroundColor(appState.currentColorScheme.lowerBackground)
            Text("Hues: \(String(format: "%.2f", hue))")
              .font(.system(.body, design: .serif))
              .foregroundColor(appState.currentColorScheme.lowerBackground)
          }
          HStack(spacing: 8) {
            Image(systemName: "drop.halffull")
              .foregroundColor(appState.currentColorScheme.lowerBackground)
            Text("Saturation: \(String(format: "%.2f", saturation))")
              .font(.system(.body, design: .serif))
              .foregroundColor(appState.currentColorScheme.lowerBackground)
          }
          HStack(spacing: 8) {
            Image(systemName: "sun.min.fill")
              .foregroundColor(appState.currentColorScheme.lowerBackground)
            Text("Brightness: \(String(format: "%.2f", brightness))")
              .font(.system(.body, design: .serif))
              .foregroundColor(appState.currentColorScheme.lowerBackground)
          }
        }
      }

      Text("Introduction to Color Application")
        .font(.system(.headline, design: .rounded))
        .foregroundColor(appState.currentColorScheme.lowerBackground)
        .padding(.top, 8)

      Text(explanation)
        .font(.system(.body, design: .serif))
        .foregroundColor(appState.currentColorScheme.lowerBackground)
        .padding(.top, 4)
    }
    .padding(24)
    .clipShape(RoundedRectangle(cornerRadius: 15))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding([.horizontal, .bottom])
    .background(appState.currentColorScheme.upperBackground)
  }
}

#Preview {
  ColorInfoSheetView(
    color: Color.blue,
    title: "Sample Color",
    hue: 240,
    saturation: 1.0,
    brightness: 1.0,
    explanation: "This is a sample color explanation."
  )
  .environmentObject(AppState())
}
