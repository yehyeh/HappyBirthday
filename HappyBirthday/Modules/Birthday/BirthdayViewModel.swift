//
//  BirthdayViewModel.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

class BirthdayViewModel: ObservableObject  {
    let baby: Baby
    let theme: BirthdayThemable = BirthdayTheme.green//BirthdayViewModel.randomTheme
    var headerTopText: String { "Today \(baby.name) is" }
    var headerLeftImagePath: String { "swirls.left" }
    var headerAgeImagePath: String { "0" }
    var headerRightImagePath: String { "swirls.right" }
    var headerBottomText: String { "Months old!" }
    var shareButtonColor: Color { Color(hex: "EF7B7B") }
    var shareButtonImagePath: String { "button.share" }
    var shareButtonText: String { "Share the news" }
    var logoImagePath: String { "logo.nanit" }
    var backButtonImagePath: String { "button.back" }

    func onShareTapped() {
    }

    func onAvatarTapped() {
    }

    func onBackTapped() {
    }

    init(baby: Baby) {
        self.baby = baby
    }
}

private extension BirthdayViewModel {
    var birthdayCalculation: (Int, unit: String) {
        guard let birthdate = baby.birthDate else { return (0, "") }
        let months = birthdate.monthsSinceNow()

        switch months {
            case 0:
                return (0, unit: "MONTHS")

            case 1:
                return (months, unit: "MONTH")

            case 2...11:
                return (months, unit: "MONTHS")

            default:
                let years = months/12
                return (years, unit: (years == 1) ? "YEAR": "YEARS")
        }
    }

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

extension Date {
    func monthsSinceNow() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month], from: self, to: now)
        return (components.year ?? 0) * 12 + (components.month ?? 0)
    }
}
