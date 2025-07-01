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

@MainActor
@Observable
class QuestionnaireViewModel {
    struct State: Equatable {
        var appName: String?
        var childName: String?
        var birthdayPhoto: Image?
        var birthdayDate: Date
        var birthdayCardGenerationIsAvailable: Bool { !(childName?.isEmpty ?? true) }
        var navigationDestination: State.NavigationDestination?
        enum NavigationDestination {
            case birthdayCard
        }
        var error: StateError?
        
        enum StateError: Error, Equatable {
            case emptyChildName
            case ageIsInWrongRange
        }
        
        init(appName: String?,
             childName: String? = nil,
             birthdayPhoto: Image? = nil,
             birthdayDate: Date = Date.now,
             navigationDestination: State.NavigationDestination? = nil,
             error: StateError? = nil) {
            self.appName = appName
            self.childName = childName
            self.birthdayPhoto = birthdayPhoto
            self.birthdayDate = birthdayDate
            self.navigationDestination = navigationDestination
            self.error = error
        }
    }
    
    private(set) var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func generateBirthdayCard() {
        guard state.birthdayCardGenerationIsAvailable else {
            state.error = .emptyChildName
            return
        }
        guard state.birthdayDate.ageInMonths < AgeLimits.maximumAgeInYears * AgeLimits.monthsPerYear &&
                state.birthdayDate.ageInMonths > AgeLimits.minimumAgeInMonths else {
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
}

extension QuestionnaireViewModel {
    func setNewBirthdayPhoto(_ newValue: Image?) {
        self.state.birthdayPhoto = newValue
    }
    
    func setChildName(_ newValue: String) {
        self.state.childName = newValue.trimmingCharacters(in: .whitespaces)
    }
    
    func setBirthdayDate(_ newValue: Date) {
        self.state.birthdayDate = newValue
    }
}
