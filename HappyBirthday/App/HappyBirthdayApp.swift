//
//  HappyBirthdayApp.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 25/04/2024.
//

import SwiftUI

@main
struct HappyBirthdayApp: App {
    var body: some Scene {
        WindowGroup {
            DetailsView(viewModel: DetailViewModel())
        }
    }
}
