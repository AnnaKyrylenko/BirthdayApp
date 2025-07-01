//
//  BirthdayAppApp.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//

import SwiftUI

@main
struct BirthdayAppApp: App {
    let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    
    var body: some Scene {
        WindowGroup {
            QuestionnaireView(viewModel: .init(state: .init(appName: appName)))
        }
    }
}
