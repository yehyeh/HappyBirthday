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
            avatarImage
            foregroundImage
            headerView
            footerView
            backButton
        }
        .background(viewModel.backgroundColor)
        .toolbar(.hidden)
        .sheet(isPresented: $viewModel.isPhotoPickerPresented) {
            AvatarPicker(sourceType: viewModel.imagePickerSource,
                         selectedImage: $pickerImage)
        }
    }

    private var foregroundImage: some View {
        GeometryReader(content: { geometry in
            Image(viewModel.foregroundImagePath)
                .resizable()
                .ignoresSafeArea(.all)
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                .aspectRatio(contentMode: .fill)
        })
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
                .padding(.horizontal, 56)
                .padding(.top, 20)

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
            Spacer()
        }
    }

    private var footerView: some View {
        VStack {
            Spacer()
            logoImage
                .padding(.top, 15)
                .padding(.bottom, 53)
            shareButton
                .padding(.bottom, 53)
        }
    }

    private var avatarImage: some View {
        VStack {
            Spacer(minLength: 262)
            Button {
                viewModel.onAvatarTapped()
            } label: {
                viewModel.avatarImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.horizontal, 50)
            Spacer(minLength: 200)
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
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(viewModel.backButtonImagePath, bundle: nil)
                }.padding(.leading, 16)
                Spacer()
            }
            Spacer()
        }.padding(.top ,16)
    }
}

#Preview {
    @State var image = UIImage()
    let vm = BirthdayViewModel(baby: Baby(birthDate: Date(), name: "Cristiano Ronaldo Jr."))
    return BirthdayView(viewModel: vm, pickerImage: $image)
}
