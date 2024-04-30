//
//  DetailViewModel.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 27/04/2024.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    private enum InputState {
        case preloaded
        case missing
        case ready
    }

    var disabledShowBirthdayScreen: Bool = false
    var isPhotoPickerPresented: Bool = false
    /*private*/ var baby = Baby()

    @Published var nameText: String = "" {
        didSet {
            baby.name = nameText
            if inputState != .preloaded {
                saveNameToUserDefaults(nameText)
                updateInputState()
            }
        }
    }

    @Published var pickerImage: UIImage = UIImage() {
        didSet {
            baby.image = pickerImage
            if inputState != .preloaded {
                saveImageToUserDefaults(pickerImage)
                updateInputState()
            }
        }
    }

    @Published var pickerDate = Date() {
        didSet {
            baby.birthDate = pickerDate
            if inputState != .preloaded {
                saveBirthDateToUserDefaults(pickerDate)
                updateInputState()
            }
        }
    }
    var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    var isAvatarPlaceholderPresented: Bool {
        guard let image = baby.image else { return true }
        return image.size.equalTo(.zero)
    }

    private var inputState: InputState = .preloaded {
        didSet {
            disabledShowBirthdayScreen = inputState != .ready
        }
    }

    private var defaults = UserDefaults.standard

    func loadOnAppear() {
        nameText = loadNameFromUserDefaults()
        if let birthDate = loadBirthDateFromUserDefaults() {
            pickerDate = birthDate
        }
        if let birthday = loadBirthDateFromUserDefaults() {
            pickerDate = birthday
        }
        if let image = loadImageFromUserDefaults() {
            pickerImage = image
        }
        updateInputState()
    }

    func onUserTappedTakePhoto() {
        imagePickerSource = .camera
        isPhotoPickerPresented = true
    }

    func onUserTappedAvatar() {
        imagePickerSource = .photoLibrary
        isPhotoPickerPresented = true
    }

    private func updateInputState() {
        if baby.name.isEmpty || baby.birthDate == nil || isAvatarPlaceholderPresented {
            inputState = .missing
        } else {
            inputState = .ready
        }
    }

    private func saveBirthDateToUserDefaults(_ date: Date?) {
        defaults.setValue(date, forKey: "birthDate")
    }

    private func loadBirthDateFromUserDefaults() -> Date? {
        defaults.object(forKey: "birthDate") as? Date
    }

    private func saveNameToUserDefaults(_ name: String) {
        defaults.setValue(name, forKey: "name")
    }

    private func loadNameFromUserDefaults() -> String {
        defaults.string(forKey: "name") ?? ""
    }

    private func saveImageToUserDefaults(_ image: UIImage?) {
        guard let imageData = image?.pngData() else { return }
        defaults.setValue(imageData, forKey: "image")
    }

    private func loadImageFromUserDefaults() -> UIImage? {
        guard let imageData = defaults.data(forKey: "image") else { return nil }
        return UIImage(data: imageData)
    }
}
