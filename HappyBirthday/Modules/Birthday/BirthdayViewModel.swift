//
//  BirthdayViewModel.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

class BirthdayViewModel: ObservableObject {
    enum SheetState {
        case photoPicker(source: UIImagePickerController.SourceType)
        case share
    }

    @Published var isPresentingSheet: Bool = false
    @Published var presentingView: SheetState? {
        willSet {
            isPresentingSheet = newValue != nil
        }
    }

    private let theme: BirthdayThemable = BirthdayViewModel.randomTheme
    private(set) var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    
    let baby: Baby
    var headerTopText: String { "Today \(baby.name) is" + zeroMonthsHeaderTopTextHandler }
    var headerLeftImagePath: String { "swirls.left" }
    var headerAgeImagePath: String { Self.numericImagePath(birthdayCalculation.amount) }
    var headerRightImagePath: String { "swirls.right" }
    var headerBottomText: String { "\(birthdayCalculation.unit) old!" }
    var shareButtonColor: Color { Color(hex: "EF7B7B") }
    var shareButtonImagePath: String { "button.share" }
    var shareButtonText: String { "Share the news" }
    var logoImagePath: String { "logo.nanit" }
    var backButtonImagePath: String { "button.back" }

    func onShareTapped() {
        presentingView = .share
    }

    func onAvatarTapped() {
        presentingView = .photoPicker(source: .photoLibrary)
    }

    func onCameraTapped() {
        presentingView = .photoPicker(source: .camera)
    }

    var backgroundColor: Color { theme.backgroundColor }

    var foregroundImagePath: String { theme.foregroundImagePath }
    
    var avatarImage: Image {
        guard let image = baby.image else {
            return Image(theme.avatarPlaceholderImagePath, bundle: nil)
        }
        return Image(uiImage: image)
    }

    var cameraImagePath: String { theme.cameraImagePath }

    init(baby: Baby) {
        self.baby = baby
    }
}

private extension BirthdayViewModel {
    static func numericImagePath(_ number: Int) -> String {
        guard (1...12).contains(number) else {
            guard number == 0 else { return "" }
            return "1"
        }
        return "\(number)"
    }

    var zeroMonthsHeaderTopTextHandler: String {
        (birthdayCalculation.amount == 0) ? " almost" : ""
    }

    var birthdayCalculation: (amount: Int, unit: String) {
        guard let birthdate = baby.birthDate else { return (0, "") }
        let months = birthdate.monthsSinceNow()

        switch months {
            case 0:
                return (amount: 0, unit: "MONTH")

            case 1:
                return (amount: months, unit: "MONTH")

            case 2...11:
                return (amount: months, unit: "MONTHS")

            default:
                let years = months/12
                return (amount: years, unit: (years == 1) ? "YEAR": "YEARS")
        }
    }

    static var randomTheme: BirthdayTheme {
        switch Int.random(in: 0...2) {
            case 0:
                return .yellow
            case 1:
                return .green
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
