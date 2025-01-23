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
    @EnvironmentObject var appState: AppState
    var type: PopupType = .colorStudy

    enum PopupType {
        case colorStudy
        case colorChallenge

        var description: (title: String, message: String) {
            switch self {
            case .colorStudy:
                return (
                    "You have completed the color learning.",
                    "Next button to enter the color challenge section."
                )
            case .colorChallenge:
                return (
                    "You have completed all the color challenges.",
                    "Next button to return to the gallery."
                )
            }
        }
    }

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
                        .foregroundColor(appState.currentColorScheme.middleColor)
                    Spacer()
                    Image(systemName: "checkmark")
                        .padding(.trailing, 24)
                        .font(.system(size: 40))
                        .foregroundColor(appState.currentColorScheme.middleColor)
                }
                .padding(.bottom, 12)
                VStack(alignment: .leading, spacing: 0) {
                    Text(type.description.title)
                        .padding(.bottom, 6)

                    Text("**Click on** \(type.description.message)")
                }
                .padding(.trailing, 84)
                .padding(.bottom, 24)
                .roundedH3_12()
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(appState.currentColorScheme.lowerBackground)
                Button(action: onNextTapped) {
                    Text("Next")
                        .font(.system(size: 32, weight: .bold))
                        .tracking(2.56)
                        .foregroundColor(.white)
                        .padding(.horizontal, 42)
                        .padding(.vertical, 8)
                        .background(appState.currentColorScheme.middleColor)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 24)
                        .cornerRadius(4)
                }
            }
            .frame(width: 374, height: 190, alignment: .topLeading)
            .padding(.leading, 16)
            .background(appState.currentColorScheme.upperBackground)
        }
        .frame(width: 374, height: 360)
        .background(appState.currentColorScheme.upperBackground)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(appState.currentColorScheme.middleColor, lineWidth: 0.25)
        )
        .shadow(color: .black.opacity(0.15), radius: 6, y: 2)
    }
}

#Preview {
    Group {
        CongrPopup(onNextTapped: {}, type: .colorStudy)
        CongrPopup(onNextTapped: {}, type: .colorChallenge)
    }
    .environmentObject(AppState())
}
