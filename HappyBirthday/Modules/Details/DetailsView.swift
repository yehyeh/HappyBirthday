//
//  DetailsView.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 25/04/2024.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailViewModel

    enum Const {
        static let title = "Happy Birthday!"
        static let namePlaceholder = "Baby Name"
        static let birthDatePlaceholder = "Birthday"
        static let birthDateCallToAction = "Birth Date"
        static let buttonTitle = "Show birthday screen"
    }

    var body: some View {
        let _ = Self._printChanges()

        NavigationStack {
            Spacer()
            VStack(alignment: .center, spacing: 24) {

                nameInputView

                birthDatePicker

                avatarInputView

                birthdayScreenButton
            }
            Spacer()
                .navigationTitle(Const.title)
                .sheet(isPresented: $viewModel.isPhotoPickerPresented) {
                    AvatarPicker(sourceType: viewModel.imagePickerSource, selectedImage: $viewModel.pickerImage)
                }
        }
        .onAppear {
            viewModel.loadOnAppear()
        }
    }

    // MARK: - Name
    private var nameInputView: some View {
        /*

         YY_TODO: iOS 17 Bug: related to textfield becoming firstReponder when DatePicker is open.
         -[RTIInputSystemClient remoteTextInputSessionWithID:performInputOperation:]  perform input operation requires a valid sessionID. inputModality = Keyboard, inputOperation = <null selector>, customInfoType = UIEmojiSearchOperations

         */

        TextField(Const.namePlaceholder, text: $viewModel.nameText)
            .textInputAutocapitalization(.words)
            .font(.headline)
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
    }

    // MARK: - Birthdate picker
    private var birthDatePicker: some View {
        let datePicker = DatePicker(Const.birthDatePlaceholder, selection: $viewModel.pickerDate, in: ...Date(), displayedComponents: .date)
            .font(.subheadline)
            .labelsHidden()

        return HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Spacer()
            Text(Const.birthDatePlaceholder)
            datePicker
            Spacer()
        }
    }
    
    // MARK: - Avatar picker
    private var avatarInputView: some View {
        VStack {
            avatarView
                .onTapGesture {
                    viewModel.onUserTappedAvatar()
                }
            Button("Take a Photo") {
                viewModel.onUserTappedTakePhoto()
            }
        }
    }

    @ViewBuilder
    private var avatarView: some View {
        if viewModel.isAvatarPlaceholderPresented {
            Self.picturePlaceholder
        } else {
            Self.picture(Image(uiImage: viewModel.pickerImage))
        }
    }

    static private func picture(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
    }
    
    static private var picturePlaceholder: some View {
        Image(systemName: "face.dashed")
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .foregroundColor(.accentColor)
            .shadow(radius: 5)
    }

    // MARK: - Button
    @ViewBuilder
    private var birthdayScreenButton: some View {

        NavigationLink(destination: {
            birthdayScreen
        }, label: {
            Text(Const.buttonTitle)
                .font(.callout)
                .foregroundColor(.accentColor)
        })
        .disabled(viewModel.disabledShowBirthdayScreen)
    }

    // MARK: - Birthday screen
    private var birthdayScreen: some View {
        BirthdayView(viewModel: BirthdayViewModel(baby: viewModel.baby))
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailsView(viewModel: DetailViewModel())
}
