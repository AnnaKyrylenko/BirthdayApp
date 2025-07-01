//
//  QuestionnaireView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//

import SwiftUI

struct QuestionnaireView: View {
    @State var viewModel: QuestionnaireViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.generalSpacing) {
                VStack(alignment: .leading,
                       spacing: Constants.requiredInfoSpacing) {
                    TextField(StringConstants.addChildPlaceholder,
                              text: Binding(get: {
                        viewModel.state.childName ?? ""
                    }, set: { childName in
                        viewModel.setChildName(childName)
                    }))
                    BirthdayDatePickerView(birthdayDate: Binding(get: {
                        viewModel.state.birthdayDate
                    },
                                                                 set: { date in
                        viewModel.setBirthdayDate(date)
                    }))
                }
                BirthdayPhotoView()
                Spacer()
                Button {
                    viewModel.generateBirthdayCard()
                } label: {
                    Text(StringConstants.showBirthdayScreen)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(Color.mainButton.opacity(viewModel.state.birthdayCardGenerationIsAvailable ? 1 : 0.5))
                        .clipShape(Capsule())
                }
                .disabled(!viewModel.state.birthdayCardGenerationIsAvailable)
            }
            .padding()
            .navigationTitle(viewModel.state.appName ?? StringConstants.defaultTitle)
            .navigationDestination(isPresented: Binding {
                viewModel.state.navigationDestination != nil
            } set: { isPushed in
                viewModel.updateNavigationDestination(isPushed: isPushed)
            }) {
                switch viewModel.state.navigationDestination {
                case .birthdayCard:
                    Text("Birthday card")
                case .none:
                    Text("Birthday card error")
                }
            }
        }
    }
}

extension QuestionnaireView {
    enum StringConstants {
        static let defaultTitle: String = "Title"
        static let addChildPlaceholder: String = "Add the child's name there 👶"
        static let showBirthdayScreen: String = "Show birthday screen"
    }
    
    enum Constants {
        static let generalSpacing: CGFloat = 24
        static let requiredInfoSpacing: CGFloat = 16
    }
}

#Preview {
    QuestionnaireView(viewModel: .init(state: .init(appName: "PreviewName", birthdayDate: Date())))
}
