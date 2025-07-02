//
//  BabyPhotoView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 02.07.2025.
//

import SwiftUI

struct BabyPhotoView: View {
    @State var viewModel: BabyPhotoViewModel
    var body: some View {
        ZStack {
            viewModel.state.theme.placeholderImage
                .resizable()
                .scaledToFit()
            if let babyPhoto = viewModel.state.babyPhoto {
                babyPhoto
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            }
            Circle()
                .stroke(viewModel.state.theme.borderColor,
                        lineWidth: 7)
                
        }
        .frame(width: 220, height: 220)
    }
}
