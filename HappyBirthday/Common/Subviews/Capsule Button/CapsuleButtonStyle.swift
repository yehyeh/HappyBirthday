//
//  CapsuleButtonStyle.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

struct TrailingImageButton: View {
    let title: String
    let imageResource: ImageResource
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                Image(imageResource)
            }
        }
        .foregroundColor(Color.white)
        .padding()
        .background(Color(hex: "EF7B7B"), in: Capsule())
    }
}

#Preview {
    TrailingImageButton(title: "Start Start Start", imageResource: ImageResource(name: "button.share", bundle: .main)) {
    }
}
