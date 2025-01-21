import SwiftUI

struct IntroView1: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 基础布局
                VStack(spacing: 0) {
                    IntroUpperSection(geometry: geometry)
                        .frame(height: 334)
                        .zIndex(6)
                    IntroLowerSection(geometry: geometry)
                        .frame(height: 488)
                        .zIndex(7)
                }
                .ignoresSafeArea()

                // 需要突破层级的视图
                VStack {
                    IntroImage(imageName: "potato_eaters",
                               width: 530.50, height: 367.50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top, 70)
                .zIndex(10)
                .ignoresSafeArea()

                ZStack(alignment: .leading) {
                    IntroImage(imageName: "starry_night",
                               width: 512, height: 357.50)
                }

                .background {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 394.50, height: 389)
                        .background(Color(red: 0.86, green: 0.91, blue: 0.95))
                        .frame(width: 394.50, height: 389)
                        .offset(x: 130, y: -74)
                }

                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .ignoresSafeArea()
                .padding(.bottom, 64)
                .padding(.leading, 120)
                .zIndex(15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// 上半部分子视图
private struct IntroUpperSection: View {
    let geometry: GeometryProxy

    var body: some View {
        ZStack {
            Color(hex: "#F5F7F2")
            HStack(alignment: .center, spacing: 64) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("The Dark Palette Years: 1880-1886")
                        .serifH1_24_italic()
                        .foregroundColor(Color(red: 0.16, green: 0.18, blue: 0.14))

                    Text("Before his artistic awakening, Van Gogh explored various careers as an art dealer, teacher, and preacher. His early works, like \"The Potato Eaters\" (1885), used dark, earthy tones to capture the raw dignity of peasant life, setting the stage for his later transformation.")
                        .roundedH2_16()
                        .foregroundColor(Color(red: 0.16, green: 0.18, blue: 0.14))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 296)
                }
                .padding(.leading, 280)
                .padding(.top, 70)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

// 下半部分子视图
private struct IntroLowerSection: View {
    let geometry: GeometryProxy

    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.95, blue: 0.98)

            VStack {
                HStack(alignment: .top, spacing: 40) {
                    // 左侧图片与背景

                    VStack(spacing: 32) {
                        // 右侧文字
                        Text("These formative years in the Netherlands shaped Van Gogh's deep connection to rural life and its people, though his art remained largely unrecognized. His dedication to capturing authentic human experiences would persist throughout his journey.")
                            .roundedH2_16()
                            .foregroundColor(Color(red: 0.09, green: 0.18, blue: 0.26))
                            .frame(maxWidth: 296)
                            .padding(.top, 32)

                        // Next按钮
                        NextBT(color: Color(red: 0.08, green: 0.40, blue: 0.73)) {
                            // 处理点击事件
                        }
                        .padding(.bottom, 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.trailing, 137)
            }
        }
    }
}

#Preview {
    IntroView1()
}
