//
//  BabyInfoViewModel.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 02.07.2025.
//

import SwiftUI

@MainActor
@Observable
class BabyInfoViewModel {
    enum AgeType: String {
        case month
        case year
    }
    struct State: Equatable {
        var width: CGFloat = .zero
        var ageType: AgeType
        var name: String
        var age: Int
        
        init(name: String,
             ageInMonth: Int) {
            self.name = name
            self.age = ageInMonth >= AgeLimits.monthsPerYear ? Int(ageInMonth / AgeLimits.monthsPerYear) : ageInMonth
            self.ageType = ageInMonth >= AgeLimits.monthsPerYear ? .year : .month
        }
    }
    
    private(set) var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func prepareBottomAgeText() -> String {
        if state.age == 1 {
            "\(state.ageType.rawValue.uppercased()) OLD!"
        } else {
            "\(state.ageType.rawValue.uppercased() + "S") OLD!"
        }
    }
}

extension BabyInfoViewModel {
    func setWidth(_ width: CGFloat) {
        self.state.width = width
    }
}
