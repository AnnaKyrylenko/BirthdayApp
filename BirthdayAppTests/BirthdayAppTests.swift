//
//  BirthdayAppTests.swift
//  BirthdayAppTests
//
//  Created by Ann Kyrylenko on 01.07.2025.
//

import Testing
import SwiftUI
import Foundation
@testable import BirthdayApp

struct BirthdayAppTests {

    @MainActor @Test func testGenerateBirthdayCardWithAllEmptyFields() {
        let appName = "App Name"
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        questionnaireViewModel.generateBirthdayCard()
        
        viewModelState.error = .emptyChildName
        
        #expect(questionnaireViewModel.state == viewModelState)
    }
    
    @MainActor @Test func testGenerateBirthdayCardWithEnteredChildNameAndDefaultValues() {
        let appName = "App Name"
        let date: Date = Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date()
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName,
                                                               childName: "Steave",
                                                               birthdayDate: date)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        questionnaireViewModel.generateBirthdayCard()
        
        viewModelState.navigationDestination = .birthdayCard
        
        #expect(questionnaireViewModel.state == viewModelState)
    }
    
    @MainActor @Test func testGenerateBirthdayCardWithEnteredChildNameAndWrongDate() {
        let appName = "App Name"
        let date: Date = Calendar.current.date(byAdding: .year, value: -14, to: Date()) ?? Date()
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName,
                                                               childName: "Steave",
                                                               birthdayDate: date)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        questionnaireViewModel.generateBirthdayCard()
        
        viewModelState.error = .ageIsInWrongRange
        
        #expect(questionnaireViewModel.state == viewModelState)
    }
    
    @MainActor @Test func testUpdateNavigationDestinationIsPushed() {
        let isPushed = true
        let appName = "App Name"
        let date: Date = Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date()
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName,
                                                               childName: "Steave",
                                                               birthdayDate: date)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        viewModelState.navigationDestination = .birthdayCard
        questionnaireViewModel.generateBirthdayCard()
        questionnaireViewModel.updateNavigationDestination(isPushed: isPushed)
        
        #expect(questionnaireViewModel.state == viewModelState)
    }
    
    @MainActor @Test func testUpdateNavigationDestinationIsNotPushed() {
        let appName = "App Name"
        let isPushed = false
        let date: Date = Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date()
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName,
                                                               childName: "Steave",
                                                               birthdayDate: date)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        viewModelState.navigationDestination = nil
        questionnaireViewModel.generateBirthdayCard()
        questionnaireViewModel.updateNavigationDestination(isPushed: isPushed)
        
        #expect(questionnaireViewModel.state == viewModelState)
    }

    @MainActor @Test func testSetNewBirthdayPhoto() {
        let image: Image = Image(uiImage: UIImage())
        var viewModelState = BirthdayCardViewModel.State.init(baby: Baby(name: "Test",
                                                                         ageInMonth: 1,
                                                                        photo: image))
        let birthdayCardViewModel = BirthdayCardViewModel(state: viewModelState,
                                                          cameraDelegate: nil,
                                                          shareDelegate: nil)
        viewModelState.baby.photo = image
        
        #expect(birthdayCardViewModel.state == viewModelState)
    }
    
    @MainActor @Test func testSetChildName() {
        let appName = "App Name"
        let name: String = "George"
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        viewModelState.childName = name
        questionnaireViewModel.setChildName(name)
        
        #expect(questionnaireViewModel.state == viewModelState)
    }
    
    @MainActor @Test func testSetBirthdayDate() {
        let appName = "App Name"
        let date: Date = Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date()
        var viewModelState = QuestionnaireViewModel.State.init(appName: appName)
        let questionnaireViewModel = QuestionnaireViewModel(state: viewModelState)
        viewModelState.birthdayDate = date
        questionnaireViewModel.setBirthdayDate(date)
        
        #expect(questionnaireViewModel.state == viewModelState)
    }
}
