//
//  ShareSheet.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 06.07.2025.
//

import UIKit
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {

    var activityItem: UIImage
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: [activityItem], applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {}

}
