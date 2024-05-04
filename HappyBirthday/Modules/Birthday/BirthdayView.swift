//
//  BirthdayView.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

struct BirthdayView: View {
    @StateObject var viewModel: BirthdayViewModel
    @Binding var pickerImage: UIImage
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            backgroundView

            avatarImage
                .padding(.horizontal, 50)

            foregroundImage

            VStack {
                headerView
                    .padding(.horizontal, 50)
                Spacer()
                footerView
            }

            backButton
                //yy_TODO: detect extra 20 insets
                .position(x: 36, y:16)//16,16
        }
        .safeAreaPadding(.all)
        .toolbar(.hidden)
        .sheet(isPresented: $viewModel.isPhotoPickerPresented) {
            AvatarPicker(sourceType: viewModel.imagePickerSource,
                         selectedImage: $pickerImage)
        }
    }

    private var foregroundImage: some View {
        Image(viewModel.foregroundImagePath)
            .resizable()
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(contentMode: .fill)
    }

    private var backgroundView: some View {
        viewModel.backgroundColor
            .ignoresSafeArea(.all)
    }

    private var headerView: some View {
        VStack {
            Text(viewModel.headerTopText.uppercased())
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .foregroundColor(Color(hex: "394562"))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 22) {
                Image(viewModel.headerLeftImagePath)
                Image(viewModel.headerAgeImagePath)
                Image(viewModel.headerRightImagePath)
            }
            .padding(.top, 13)
            .padding(.bottom, 14)

            Text(viewModel.headerBottomText.uppercased())
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .foregroundColor(Color(hex: "394562"))
        }
    }

    private var footerView: some View {
        VStack {
            logoImage
                .padding(.top, 15)
                .padding(.bottom, 53)
            shareButton
                .padding(.bottom, 53)
        }
    }

    private var avatarImage: some View {
        Button {
            viewModel.onAvatarTapped()
        } label: {
            viewModel.avatarImage
                .resizable()
//                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        }
    }

    private var logoImage: some View {
        Image(viewModel.logoImagePath, bundle: nil)
    }

    private var shareButton: some View {
        TrailingImageButton(title: viewModel.shareButtonText,
                            imageResource: ImageResource(name: viewModel.shareButtonImagePath, bundle: .main)) {
            viewModel.onShareTapped()
        }
    }

    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(viewModel.backButtonImagePath, bundle: nil)
        }
    }
}

#Preview {
    @State var image = UIImage()
    let vm = BirthdayViewModel(baby: Baby(birthDate: Date(), name: "Cristiano Ronaldo Jr."))
    return BirthdayView(viewModel: vm, pickerImage: $image)
}
