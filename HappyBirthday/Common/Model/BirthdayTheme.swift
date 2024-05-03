//
//  BirthdayTheme.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

protocol BirthdayThemable {
    var backgroundColor: Color { get }
    var backgroundImagePath: String { get }
    var avatarPlaceholderImagePath: String { get }
    var cameraImagePath: String { get }
}

enum BirthdayTheme: BirthdayThemable {
    case yellow
    case blue
    case green

    var backgroundColor: Color {
        switch self {
            case .yellow:
                return Color(hex: "FEEFCB")
            case .blue:
                return Color(hex: "DAF1F6")
            case .green:
                return Color(hex: "C5E8DF")
        }
    }

    var avatarPlaceholderImagePath: String {
        switch self {
            case .yellow:
                return "placeholder.border.yellow"
            case .blue:
                return "placeholder.border.blue"
            case .green:
                return "placeholder.border.green"
        }
    }

    var backgroundImagePath: String {
        switch self {
            case .yellow:
                return "background.elephant"
            case .blue:
                return "background.pelican"
            case .green:
                return "background.fox"
        }
    }

    var cameraImagePath: String {
        switch self {
            case .yellow:
                return "camera.yellow"
            case .blue:
                return "camera.blue"
            case .green:
                return "camera.green"
        }
    }
}
