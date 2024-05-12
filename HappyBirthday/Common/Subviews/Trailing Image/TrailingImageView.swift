//
//  TrailingImageView.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

struct TrailingImageView: View {
    let title: String
    let imageResource: ImageResource

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
            Image(imageResource)
        }
        .foregroundColor(.white)
        .padding()
    }
}

#Preview {
    TrailingImageView(title: "Start Start Start", imageResource: ImageResource(name: "button.share", bundle: .main))
}
