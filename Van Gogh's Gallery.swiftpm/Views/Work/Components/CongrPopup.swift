//
//  File.swift
//
//
//  Created by 潘令川 on 2025/1/23.
//
import Foundation
import SwiftUI

struct CongrPopup: View {
    var onNextTapped: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // 装饰图案部分
            DecorativeCircles()
                .frame(width: 374)

            // 内容部分
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("Congratulations")
                        .roundedH1_24()
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.47, green: 0.58, blue: 0.20))
                    Spacer()
                    Image(systemName: "checkmark")
                        .padding(.trailing, 24)
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 0.47, green: 0.58, blue: 0.20))
                }
                .padding(.bottom, 12)
                VStack(alignment: .leading, spacing: 0) {
                    Text("You have completed the color learning.")
                        .padding(.bottom, 6)

                    Text("**Click on** Next button to enter the color challenge section.")
                }
                .padding(.trailing, 84)
                .padding(.bottom, 24)
                .roundedH3_12()
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color(red: 0.16, green: 0.18, blue: 0.14))
                Button(action: onNextTapped) {
                    Text("Next")
                        .font(.system(size: 32, weight: .bold))
                        .tracking(2.56)
                        .foregroundColor(.white)
                        .padding(.horizontal, 42)
                        .padding(.vertical, 8)
                        .background(Color(red: 0.47, green: 0.58, blue: 0.20))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 22)
                        .cornerRadius(4)
                }
            }
            .frame(width: 374, height: 190, alignment: .topLeading)
            .padding(.leading, 16)
            .background(Color(red: 0.96, green: 0.97, blue: 0.95))
        }
        .frame(width: 374, height: 360)
        .background(Color(red: 0.96, green: 0.97, blue: 0.95))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color(red: 0.47, green: 0.58, blue: 0.20), lineWidth: 0.25)
        )
        .shadow(color: .black.opacity(0.15), radius: 6, y: 2)
    }
}

#Preview {
    CongrPopup(onNextTapped: {})
}
