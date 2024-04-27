//
//  HappyBirthdayApp.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 25/04/2024.
//

import SwiftUI
import SwiftData

@main
struct HappyBirthdayApp: App {
    var sharedModelContainer: ModelContainer = {
        do {
            return try ModelContainer()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            DetailsView()
        }
        .modelContainer(sharedModelContainer)
    }
}
