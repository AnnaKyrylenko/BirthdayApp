//
//  BabyInfoView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 02.07.2025.
//


import SwiftUI

struct BabyInfoView: View {
    @State var viewModel: BabyInfoViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            Text("TODAY \(viewModel.state.name.uppercased()) IS")
                .font(.system(size: 21, weight: .semibold))
                .foregroundStyle(.text)
                .layoutPriority(0)
                .multilineTextAlignment(.center)
            HStack(spacing: 22) {
                Image("left_swirls")
                Image("\(viewModel.state.age)")
                Image("right_swirls")
            }
            .layoutPriority(1)
            Text(viewModel.prepareBottomAgeText())
                .font(.system(size: 21, weight: .semibold))
                .foregroundStyle(.text)
                .padding(.top, 10)
        }
    }
}

