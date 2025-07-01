//
//  Date+Extension.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//

import Foundation

extension Date {
    var ageInMonths: Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month], from: self, to: now)
        let years = components.year ?? 0
        let months = components.month ?? 0
        return years * 12 + months
    }
}
