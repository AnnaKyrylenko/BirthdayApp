//
//  BirthdayCardViewModel.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 02.07.2025.
//

import SwiftUI

struct Baby {
    var name: String
    var ageInMonth: Int
    var photo: Image?
}

@MainActor
@Observable
class BirthdayCardViewModel {
    enum Theme: CaseIterable {
        case blue
        case green
        case yellow
        
        var backgroundColor: Color {
            switch self {
            case .blue:
                return .blueLight
            case .green:
                return .greenLight
            case .yellow:
                return .yellowLight
            }
        }
        
        var borderColor: Color {
            switch self {
            case .blue:
                return .blueDark
            case .green:
                return .greenDark
            case .yellow:
                return .yellowDark
            }
        }
        
        var placeholderImage: Image {
            switch self {
            case .blue:
                return Image("baby_blue")
            case .green:
                return Image("baby_green")
            case .yellow:
                return Image("baby_yellow")
            }
        }
        
        var maskImage: Image {
            switch self {
            case .blue:
                return Image("mask_blue")
            case .green:
                return Image("mask_green")
            case .yellow:
                return Image("mask_yellow")
            }
        }
        
        var cameraImage: Image {
            switch self {
            case .blue:
                return Image("camera_blue")
            case .green:
                return Image("camera_green")
            case .yellow:
                return Image("camera_yellow")
            }
        }
    }
    struct State {
        var selectedTheme: Theme = { Theme.allCases.randomElement() ?? .blue }()
        var baby: Baby
        var isNeedToHideShareButton: Bool = false
        
        init(baby: Baby) {
            self.baby = baby
        }
    }
    
    private(set) var state: State
    weak var cameraDelegate: CameraDelegate?
    weak var shareDelegate: ShareDelegate?
    
    var babyPhotoViewModel: BabyPhotoViewModel?
    
    init(state: State,
         cameraDelegate: CameraDelegate?,
         shareDelegate: ShareDelegate?) {
        self.state = state
        self.cameraDelegate = cameraDelegate
        self.shareDelegate = shareDelegate
    }
    
    func configureBabyInfoViewModel() -> BabyInfoViewModel {
        return BabyInfoViewModel(state: .init(name: state.baby.name,
                                              ageInMonth: state.baby.ageInMonth))
    }
    
    func configureBabyPhotoViewModel() -> BabyPhotoViewModel {
        if let babyPhotoViewModel {
            return babyPhotoViewModel
        } else {
            babyPhotoViewModel = BabyPhotoViewModel(state: .init(theme: state.selectedTheme,
                                                                 babyPhoto: state.baby.photo),
                                                    delegate: cameraDelegate)
            return babyPhotoViewModel ?? BabyPhotoViewModel(state: .init(theme: .blue),
                                                            delegate: nil)
        }
    }
    
    func shareSnapshot(snapshot: UIImage) {
        
        shareDelegate?.shareSnapshot(snapshot)
    }
    
    func setButtonsVisible(_ visible: Bool) {
        babyPhotoViewModel?.setIsCameraIconVisible(visible)
        state.isNeedToHideShareButton = !visible
    }
    
    func setNewPhoto(_ photo: Image?) {
        babyPhotoViewModel?.setBabyPhoto(photo)
    }
}
