//
//  BirthdayPhotoViewModel.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//

import SwiftUI
import PhotosUI

@MainActor
@Observable
class BirthdayPhotoViewModel {
    struct State {
        var birthdayPhoto: Image?
        var openGallery: Bool
        var selectedPhoto: PhotosPickerItem?
        
        var error: StateError?
        
        enum StateError: Error, Equatable {
            case selectedImageLoadingFailed
            case cantGetUIImageFromData
        }
        
        init(birthdayPhoto: Image?,
             openGallery: Bool = false,
             selectedPhoto: PhotosPickerItem? = nil,
             error: StateError? = nil) {
            self.birthdayPhoto = birthdayPhoto
            self.openGallery = openGallery
            self.selectedPhoto = selectedPhoto
            self.error = error
        }
    }
    
    private(set) var state: State
    weak var cameraDelegate: CameraDelegate?
    
    init(state: State,
         cameraDelegate: CameraDelegate?) {
        self.state = state
        self.cameraDelegate = cameraDelegate
    }
    
    func openCamera() {
        cameraDelegate?.showCamera()
    }
    
    func openGallery() {
        state.openGallery = true
    }
    
    func loadPhoto() {
        Task {
            do {
                if let loadedImage = try await state.selectedPhoto?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: loadedImage){
                    state.birthdayPhoto = Image(uiImage: uiImage)
                } else {
                    state.error = .cantGetUIImageFromData
                }
            } catch {
                state.error = .selectedImageLoadingFailed
            }
        }
    }
    
    func setNewBirthdayPhoto(_ newValue: Image?) {
        self.state.birthdayPhoto = newValue
    }
}

extension BirthdayPhotoViewModel {
    
    func setSelectedPhoto(_ photo: PhotosPickerItem?) {
        self.state.selectedPhoto = photo
    }
    
    func setIsOpenGallery(_ isOpenGallery: Bool) {
        self.state.openGallery = isOpenGallery
    }
}
