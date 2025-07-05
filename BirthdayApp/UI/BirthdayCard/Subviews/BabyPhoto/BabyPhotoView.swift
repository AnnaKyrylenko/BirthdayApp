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
            Group {
                if let babyPhoto = viewModel.state.babyPhoto {
                    babyPhoto
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } else {
                    viewModel.state.theme.placeholderImage
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: Constants.circleDiametr,
                   height: Constants.circleDiametr)
            .clipped()
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            viewModel.setCircleRadius(geometry.size.height / 2)
                        }
                        .onChange(of: geometry.size.height) { _, newValue in
                            viewModel.setCircleRadius(newValue / 2)
                        }
                }
            }
            Circle()
                .stroke(viewModel.state.theme.borderColor,
                        lineWidth: Constants.borderWidth)
            viewModel.state.theme.cameraImage
                .resizable()
                .scaledToFit()
                .frame(width: Constants.cameraImageSideLengthg,
                       height: Constants.cameraImageSideLengthg)
                .position(viewModel.cameraIconPosition(angle: Constants.cameraAnglePosition))
            
        }
        .frame(width: Constants.circleDiametr,
               height: Constants.circleDiametr)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.openCamera()
        }
    }
}

extension BabyPhotoView {
    enum Constants {
        static let cameraImageSideLengthg: CGFloat = 36
        static let cameraAnglePosition: CGFloat = 45
        static let borderWidth: CGFloat = 7
        static let circleDiametr: CGFloat = 220
    }
}
