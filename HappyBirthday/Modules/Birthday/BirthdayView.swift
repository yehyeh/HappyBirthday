//
//  BirthdayView.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 03/05/2024.
//

import SwiftUI

struct BirthdayView: View {
    @StateObject var viewModel: BirthdayViewModel

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                backgroundView

                forgroundImage

                VStack {
                    headerView
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        .frame(maxWidth: proxy.size.width * 263/375, maxHeight: .infinity, alignment: .top)

                    Spacer(minLength: 20)
                    
                    avatarImage

                    footerView
                }
            }
            .frame(width: proxy.size.width)
        }
        .overlay(alignment: .topLeading) {
            backButton
                .position(x: 16, y: 16)
        }
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

            HStack(spacing: 22) {
                Image(viewModel.headerLeftImagePath)
                Image(viewModel.headerAgeImagePath)
                Image(viewModel.headerRightImagePath)
            }
            .padding(EdgeInsets(top: 13, leading: 0, bottom: 14, trailing: 0))

            Text(viewModel.headerBottomText.uppercased())
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .foregroundColor(Color(hex: "394562"))
        }
    }

    private var footerView: some View {
        VStack {
            logoImage
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 53, trailing: 0))
            shareButton
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 53, trailing: 0))
        }
    }

    private var avatarImage: some View {
        VStack {
            Spacer()

            Button {
                viewModel.onAvatarTapped()
            } label: {
                viewModel.avatarImage
                    .frame(maxWidth: .some(225), maxHeight: .some(225), alignment: .center)
                    .scaledToFit()
            }
            .clipShape(Circle())
            
            Spacer()
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

    private var forgroundImage: some View {
        Image(viewModel.backgroundImagePath)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }

    private var backButton: some View {
        Button {
            viewModel.onBackTapped()
        } label: {
            Image(viewModel.backButtonImagePath, bundle: nil)
        }
    }
}

#Preview {
    let vm = BirthdayViewModel(baby: Baby(birthDate: Date(), name: "Cristiano Ronaldo Jr."))
    return BirthdayView(viewModel: vm)
}
