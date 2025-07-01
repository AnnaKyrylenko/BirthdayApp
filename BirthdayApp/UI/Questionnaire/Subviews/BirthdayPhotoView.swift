//
//  BirthdayPhotoView.swift
//  BirthdayApp
//
//  Created by Ann Kyrylenko on 01.07.2025.
//


import SwiftUI
import PhotosUI

struct BirthdayPhotoView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.softYellow)
            Image(systemName: "plus.app.fill")
                .resizable()
                .frame(width: 60,
                       height: 60)
                .foregroundStyle(Color.darkYellow)
        }
        .frame(width: 200,
               height: 200)
    }
}

#Preview {
    BirthdayPhotoView()
}
