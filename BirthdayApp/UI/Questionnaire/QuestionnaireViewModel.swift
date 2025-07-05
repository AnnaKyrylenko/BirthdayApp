//
//  QuestionnaireViewModel.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//


import SwiftUI

enum AgeLimits {
    static let minimumAgeInMonths: Int = 1
    static let maximumAgeInYears: Int = 12
    static let monthsPerYear: Int = 12
}

protocol CameraDelegate: AnyObject {
    func showCamera()
}

@MainActor
@Observable
class QuestionnaireViewModel {
    struct State: Equatable {
        var appName: String?
        var childName: String?
        var birthdayDate: Date
        var birthdayCardGenerationIsAvailable: Bool { !(childName?.isEmpty ?? true) && checkSelectedBirthDateIsValid() }
        
        var navigationDestination: State.NavigationDestination?
        enum NavigationDestination {
            case birthdayCard
        }
        
        var fullScreenCover: FullScreenCover? = nil
        enum FullScreenCover {
            case camera
        }
        
        var error: StateError?
        
        enum StateError: Error, Equatable {
            case emptyChildName
            case ageIsInWrongRange
        }
        
        init(appName: String?,
             childName: String? = nil,
             birthdayDate: Date = Date.now,
             navigationDestination: State.NavigationDestination? = nil,
             error: StateError? = nil) {
            self.appName = appName
            self.childName = childName
            self.birthdayDate = birthdayDate
            self.navigationDestination = navigationDestination
            self.error = error
        }
        
        fileprivate func checkSelectedBirthDateIsValid() -> Bool {
            return birthdayDate.ageInMonths <= AgeLimits.maximumAgeInYears * AgeLimits.monthsPerYear &&
            birthdayDate.ageInMonths >= AgeLimits.minimumAgeInMonths
        }
    }
    
    private(set) var state: State
    
    var birthdayPhotoViewModel: BirthdayPhotoViewModel?
    var birthdayCardViewModel: BirthdayCardViewModel?
    
    init(state: State) {
        self.state = state
        self.birthdayPhotoViewModel = BirthdayPhotoViewModel(state: .init(birthdayPhoto: nil),
                                                             cameraDelegate: self)
    }
    
    func generateBirthdayCard() {
        guard state.birthdayCardGenerationIsAvailable else {
            state.error = .emptyChildName
            return
        }
        guard state.checkSelectedBirthDateIsValid() else {
            state.error = .ageIsInWrongRange
            return
        }
        state.navigationDestination = .birthdayCard
    }
    
    func updateNavigationDestination(isPushed: Bool) {
        if !isPushed {
            state.navigationDestination = nil
        }
    }
    
    func generateBirthdayCardViewModel() -> BirthdayCardViewModel {
        if let birthdayCardViewModel {
            return birthdayCardViewModel
        } else {
            birthdayCardViewModel = BirthdayCardViewModel(state: .init(baby: Baby(name: state.childName ?? "",
                                                                 ageInMonth: state.birthdayDate.ageInMonths,
                                                                 photo: birthdayPhotoViewModel?.state.birthdayPhoto
                                                                )),
                                         delegate: self)
            return birthdayCardViewModel ?? .init(state: .init(baby: Baby(name: "Default Baby",
                                                                          ageInMonth: -1)),
                                                  delegate: nil)
        }
    }
}

extension QuestionnaireViewModel {
    func setNewBirthdayPhoto(_ newValue: Image?) {
        birthdayPhotoViewModel?.setNewBirthdayPhoto(newValue)
        birthdayCardViewModel?.setNewPhoto(newValue)
    }
    
    func setChildName(_ newValue: String) {
        self.state.childName = newValue.trimmingCharacters(in: .whitespaces)
    }
    
    func setBirthdayDate(_ newValue: Date) {
        self.state.birthdayDate = newValue
    }
    
    func onUpdateSelectedFullScreen(isPresented: Bool) {
        if !isPresented {
            dismissSelectedSheet()
        }
    }
}

//MARK: FullScreenCover
extension QuestionnaireViewModel {
    
    func openCameraFullScreen() {
        Task {
            guard state.fullScreenCover == nil else { return }
            state.fullScreenCover = .camera
        }
    }
    
    private func dismissSelectedSheet() {
        guard let fullScreenCover = state.fullScreenCover else { return }
        switch fullScreenCover {
        case .camera:
            //MARK: Handle specific action on dismiss camera there
            break
        }
        state.fullScreenCover = nil
    }
}

extension QuestionnaireViewModel: @preconcurrency CameraDelegate {
    func showCamera() {
        openCameraFullScreen()
    }
}
