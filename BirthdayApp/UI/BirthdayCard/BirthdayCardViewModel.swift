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
        
    }
    struct State {
        var selectedTheme: Theme = { Theme.allCases.randomElement() ?? .blue }()
        var baby: Baby
        
        init(baby: Baby) {
            self.baby = baby
        }
    }
    
    private(set) var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func configureBabyInfoViewModel() -> BabyInfoViewModel {
        return BabyInfoViewModel(state: .init(name: state.baby.name,
                                              ageInMonth: state.baby.ageInMonth))
    }
    
    func configureBabyPhotoViewModel() -> BabyPhotoViewModel {
        return BabyPhotoViewModel(state: .init(theme: state.selectedTheme,
                                               babyPhoto: state.baby.photo))
    }
}
