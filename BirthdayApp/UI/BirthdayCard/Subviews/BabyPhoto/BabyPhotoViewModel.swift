//
//  BabyPhotoViewModel.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 02.07.2025.
//

import SwiftUI

@MainActor
@Observable
class BabyPhotoViewModel {
    struct State {
        var theme: BirthdayCardViewModel.Theme
        var babyPhoto: Image?
    }
    
    private(set) var state: State
    
    init(state: State) {
        self.state = state
    }
}
