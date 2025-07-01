//
//  BirthdayDatePickerView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//


import SwiftUI

struct BirthdayDatePickerView: View {
    @Binding var birthdayDate: Date
    
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let now = Date()
        let monthAgo = calendar.date(byAdding: .month,
                                     value: -AgeLimits.minimumAgeInMonths,
                                     to: now) ?? now
        
        let twelveYearsAgo = calendar.date(byAdding: .year,
                                           value: -AgeLimits.maximumAgeInYears,
                                           to: now) ?? now
        return twelveYearsAgo...monthAgo
    }()
    
    var body: some View {
        DatePicker(
            "Birthday date",
            selection: $birthdayDate,
            in: dateRange,
            displayedComponents: [.date])
    }
}
