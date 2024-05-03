//
//  BirthdayViewModel.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

class BirthdayViewModel: ObservableObject  {
    let theme: BirthdayThemable = BirthdayViewModel.randomTheme
    var headerTopText: String { "TODAY CRISTIANO RONALDO JUNIOR IS" }
    var headerLeftImagePath: String { "swirls.left" }
    var headerAgeImagePath: String { "0" }
    var headerRightImagePath: String { "swirls.right" }
    var headerBottomText: String { "MONTHS OLD!" }
    var shareButtonColor: Color { Color(hex: "EF7B7B") }
    var shareButtonImagePath: String { "button.share" }
    var shareButtonText: String { "Share the news" }
    var logoImagePath: String { "logo.nanit" }
    var backButtonImagePath: String { "button.share" }


    func onShareTapped() {
    }
}

private extension BirthdayViewModel {
    static var randomTheme: BirthdayTheme {
        switch Int.random(in: 0...2) {
            case 0:
                return .yellow
            case 1:
                return .green
//            case 2:
            default:
                return .blue

        }
    }
}
