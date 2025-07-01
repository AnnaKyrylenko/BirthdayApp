//
//  BirthdayPhotoView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//


import SwiftUI
import PhotosUI

struct BirthdayPhotoView: View {
    @State var viewModel: BirthdayPhotoViewModel
    var body: some View {
        Menu {
            Button {
                viewModel.openCamera()
            } label: {
                Label(StringConstants.makeThePhoto,
                      systemImage: StringConstants.makeThePhotoIconName)
            }
            Button {
                viewModel.openGallery()
            } label: {
                Label(StringConstants.pickThePhotoFromGalerry,
                      systemImage: StringConstants.pickThePhotoFromGalerryIconName)
            }
        } label: {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.softYellow)
                .overlay {
                    if let birthdayPhoto = viewModel.state.birthdayPhoto {
                        birthdayPhoto
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    } else {
                        Image(systemName: StringConstants.addIconName)
                            .resizable()
                            .frame(width: Constants.smallImageSideLength,
                                   height: Constants.smallImageSideLength)
                            .foregroundStyle(Color.darkYellow)
                    }
                }
            
                .cornerRadius(Constants.cornerRadius)
                .clipped()
        }
        .frame(width: Constants.bigImageSideLength,
               height: Constants.bigImageSideLength)
        .photosPicker(isPresented: Binding(get: {
            viewModel.state.openGallery
        }, set: { isOpenGallery in
            viewModel.setIsOpenGallery(isOpenGallery)
        }),
                      selection: Binding(get: {
            viewModel.state.selectedPhoto
        }, set: { newPhoto in
            viewModel.setSelectedPhoto(newPhoto)
        }),
                      matching: .images)
        .onChange(of: viewModel.state.selectedPhoto) { _, _ in
            viewModel.loadPhoto()
        }
    }
}

extension BirthdayPhotoView {
    enum StringConstants {
        static let makeThePhoto: String = "Make the photo"
        static let makeThePhotoIconName: String = "camera.fill"
        static let pickThePhotoFromGalerry: String = "Pick photo from gallery"
        static let pickThePhotoFromGalerryIconName: String = "photo.badge.arrow.down.fill"
        static let addIconName: String =  "plus.app.fill"
    }
    
    enum Constants {
        static let bigImageSideLength: CGFloat = 200
        static let smallImageSideLength: CGFloat = 60
        static let cornerRadius: CGFloat = 10
    }
}

#Preview {
    BirthdayPhotoView(viewModel: BirthdayPhotoViewModel(state: .init(birthdayPhoto: nil),
                                                        cameraDelegate: nil))
}
