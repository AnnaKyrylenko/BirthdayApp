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
            VStack(spacing: 19) {
                BabyPhotoView(viewModel: viewModel.configureBabyPhotoViewModel())
                Image(.nanitLabel)
            }
            viewModel.state.selectedTheme.maskImage
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                BabyInfoView(viewModel: viewModel.configureBabyInfoViewModel())
                Spacer()
            }
            .padding(.top, 20)
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

