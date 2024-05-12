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
        .sheet(isPresented: $viewModel.isPresentingSheet) {
            switch viewModel.presentingView {
                case .photoPicker(let source):
                    AvatarPicker(sourceType: source,
                                 selectedImage: $pickerImage)
                default:
                    Text("L:")
            }
        }
    }

    private var foregroundImage: some View {
        GeometryReader(content: { geometry in
            Image(viewModel.foregroundImagePath)
                .resizable()
                .ignoresSafeArea(.all)
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                .aspectRatio(contentMode: .fill)
                .allowsHitTesting(false)
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
        .allowsHitTesting(false)
    }

    private var footerView: some View {
        VStack {
            Spacer()
                .allowsHitTesting(false)
            logoImage
                .padding(.top, 15)
                .padding(.bottom, 53)
                .allowsHitTesting(false)
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
        let image = Image(uiImage: pickerImage) // YY_TODO: - ganarate screen snapshot
        return ShareLink(item: image,
                         preview: SharePreview("Happy Birthday App",
                         image: image)) {
            HStack(spacing: 8) {
                Text(viewModel.shareButtonText)
                Image(ImageResource(name: viewModel.shareButtonImagePath, bundle: .main))
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color(hex: "EF7B7B"), in: Capsule())
        }
    }

    private var backButton: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(viewModel.backButtonImagePath, bundle: nil)
                }
                .padding(.leading, 16)

                Spacer()
                    .allowsHitTesting(false)
            }

            Spacer()
                .allowsHitTesting(false)
        }
        .padding(.top ,16)
    }
}

#Preview {
    @State var image = UIImage()
    let vm = BirthdayViewModel(baby: Baby(birthDate: Date(), name: "Cristiano Ronaldo Jr."))
    return BirthdayView(viewModel: vm, pickerImage: $image)
}
