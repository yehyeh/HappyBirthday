//
//  DetailsView.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 25/04/2024.
//

import SwiftUI
import SwiftData

struct DetailsView: View {
    @State private var name: String = ""
    @State private var birthDate: Date? = nil
    @State private var birthDateTextDummy: String = ""
    @State private var pickerDate = Date()
    @State private var datePickerEverClicked: Bool = false
    @State private var activateNavigationLink = false

    private let title = "Happy Birthday!"
    private let namePlaceholder = "Name"
    private let birthDatePlaceholder = "Birthday"
    private let birthDateCallToAction = "Birth Date"
    private let buttonTitle = "Show birthday screen"
    private let picture = ""
    private var pictureURL: URL? { URL(string: picture) }

    var body: some View {
        NavigationStack {
            Spacer()
            VStack(alignment: .center, spacing: 24) {

                nameInput

                if datePickerEverClicked {
                    dateInput
                } else {
                    dateInput1
                }

                avatar

                birthdayScreenButton
                    .disabled(name.isEmpty || birthDate != nil)
            }
            Spacer()
                .navigationTitle(title)
        }
    }

    @ViewBuilder
    private var nameInput: some View {
        /*

         YY_TODO: iOS 17 Bug: related to textfield becoming firstReponder when DatePicker is open.
         -[RTIInputSystemClient remoteTextInputSessionWithID:performInputOperation:]  perform input operation requires a valid sessionID. inputModality = Keyboard, inputOperation = <null selector>, customInfoType = UIEmojiSearchOperations

         */

        TextField(namePlaceholder, text: $name)
            .font(.headline)
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
    }

    @ViewBuilder
    private var dateInput1: some View {
        TextField(birthDatePlaceholder, text: $birthDateTextDummy)
            .font(.headline)
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
            .onTapGesture {
                datePickerEverClicked = true
            }
    }

    @ViewBuilder
    private var avatar: some View {
        if pictureURL != nil {
            AsyncImage(url: pictureURL) { phase in
                if let image = phase.image {
                    Self.picture(image)
                } else if phase.error != nil {
                    Self.picturePlaceholder
                } else {
                    ProgressView()
                        .frame(width: 100)
                }
            }
        }
        else {
            Self.picturePlaceholder
        }
    }

    @ViewBuilder
    private var dateInput: some View {
        let datePicker = DatePicker(birthDatePlaceholder, selection: $pickerDate, displayedComponents: .date)
            .font(.subheadline)
            .labelsHidden()

        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Spacer()
            Text(birthDatePlaceholder)
            datePicker
            Spacer()
        }
    }

    @ViewBuilder
    static private func picture(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }

    @ViewBuilder
    static private var picturePlaceholder: some View {
        Image(systemName: "face.dashed")
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .foregroundColor(.accentColor)
            .shadow(radius: 5)
    }

    @ViewBuilder
    private var birthdayScreenButton: some View {
        NavigationLink(destination: {
            birthdayScreen
        }, label: {
            Text(buttonTitle)
                .font(.callout)
                .foregroundColor(.accentColor)
        })
    }

    private var birthdayScreen: some View {
        Text("\(name)'s Birthday!")
    }
}

#Preview {
    DetailsView()
}
