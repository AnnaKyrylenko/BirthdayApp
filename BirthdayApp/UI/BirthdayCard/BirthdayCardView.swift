//
//  BirthdayCardView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 02.07.2025.
//

import SwiftUI

struct BirthdayCardView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel: BirthdayCardViewModel
    var body: some View {
        ZStack {
            viewModel.state.selectedTheme.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: Constants.babyPhotoStackPadding) {
                BabyPhotoView(viewModel: viewModel.configureBabyPhotoViewModel())
                
            }
            viewModel.state.selectedTheme.maskImage
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
                .allowsHitTesting(false)
            VStack {
                BabyInfoView(viewModel: viewModel.configureBabyInfoViewModel())
                Spacer()
                Image(.nanitLabel)
                Button {
                    viewModel.shareImage()
                } label: {
                    HStack(spacing: .zero) {
                        Text(StringConstants.shareTheNews)
                        Image(.icShare)
                    }
                    .padding(.horizontal, Constants.shareButtonTextHorizontalPadding)
                    .frame(height: Constants.shareButtonHeight)
                    .foregroundStyle(Color.white)
                    .background(Color.mainButton)
                    .clipShape(Capsule())
                }
                .padding(.vertical, Constants.shareButtonVerticalPadding)
            }
            .padding(.top, Constants.appInfoTopPadding)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(.icBack)
                }
            }
        }
    }
}

extension BirthdayCardView {
    enum StringConstants {
        static let shareTheNews = "Share the news"
    }
    
    enum Constants {
        static let shareButtonHeight: CGFloat = 42
        static let shareButtonTextHorizontalPadding: CGFloat = 21
        static let shareButtonVerticalPadding: CGFloat = 53
        static let appInfoTopPadding: CGFloat = 20
        static let babyPhotoStackPadding: CGFloat = 19
    }
}
