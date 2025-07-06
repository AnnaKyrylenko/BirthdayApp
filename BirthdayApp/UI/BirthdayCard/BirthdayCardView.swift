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
        ZStack(alignment: .bottom) {
            viewModel.state.selectedTheme.backgroundColor
                .layoutPriority(1)
            contentBuilder(isDisplayBabyPhoto: true)
                .layoutPriority(1)
            viewModel.state.selectedTheme.maskImage
                .resizable()
                .scaledToFit()
                .allowsHitTesting(false)
                .layoutPriority(1)
            contentBuilder(isDisplayBabyPhoto: false)
                .layoutPriority(1)
        }
        .ignoresSafeArea()
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
    
    func contentBuilder(isDisplayBabyPhoto: Bool) -> some View {
        VStack(spacing: 0) {
            Spacer(minLength: 20)
            BabyInfoView(viewModel: viewModel.configureBabyInfoViewModel())
                .opacity(isDisplayBabyPhoto ? 0 : 1)
            Spacer(minLength: 20)
            BabyPhotoView(viewModel: viewModel.configureBabyPhotoViewModel())
                .opacity(isDisplayBabyPhoto ? 1 : 0)
            Image(.nanitLabel)
                .opacity(isDisplayBabyPhoto ? 0 : 1)
                .padding(.top, 15)
            Button {
                viewModel.setButtonsVisible(false)
                let image = self.body.snapshot()
                viewModel.shareSnapshot(snapshot: image)
                viewModel.setButtonsVisible(true)
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
            .opacity(isDisplayBabyPhoto || viewModel.state.isNeedToHideShareButton ? 0 : 1)
            .padding(.vertical, Constants.shareButtonVerticalPadding)
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
