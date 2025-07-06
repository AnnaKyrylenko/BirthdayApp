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
        var circleRadius: CGFloat = .zero
        var theme: BirthdayCardViewModel.Theme
        var babyPhoto: Image?
        var isCameraIconVisible: Bool = true
    }
    
    private(set) var state: State
    weak var delegate: CameraDelegate?
    
    init(state: State,
         delegate: CameraDelegate?) {
        self.state = state
        self.delegate = delegate
    }
    
    func cameraIconPosition(angle: Double) -> CGPoint {
        let radians = angle * .pi / 180
        let x = state.circleRadius * cos(radians)
        let y = state.circleRadius * sin(radians)
        return CGPoint(x: state.circleRadius + x, y: state.circleRadius - y)
    }
    
    func setCircleRadius(_ radius: CGFloat) {
        state.circleRadius = radius
    }
    
    func setBabyPhoto(_ photo: Image?) {
        state.babyPhoto = photo
    }
    
    func setIsCameraIconVisible(_ visible: Bool) {
        state.isCameraIconVisible = visible
    }
    
    func openCamera() {
        delegate?.showCamera()
    }
}
