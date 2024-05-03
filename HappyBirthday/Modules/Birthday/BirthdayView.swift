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
        GeometryReader { gp in
            ZStack {
                viewModel.theme.backgroundColor.ignoresSafeArea(.all)
//                VStack {
                VStack {
                    Text(viewModel.headerTopText)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)

                    HStack(spacing: 22) {
                        Image(viewModel.headerLeftImagePath)
                        Image(viewModel.headerAgeImagePath)
                        Image(viewModel.headerRightImagePath)
                    }
                    .padding(EdgeInsets(top: 13, leading: 0, bottom: 14, trailing: 0))

                    Text(viewModel.headerBottomText)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: gp.size.width * 263/375, maxHeight: .infinity, alignment: .top)

                VStack {
                    logoImage

                    shareButton
                }

//                }

                forgroundImage
            }
        }
    }

    private var logoImage: some View {
        Image(viewModel.logoImagePath, bundle: nil)
    }

    private var shareButton: some View {
        TrailingImageButton(title: viewModel.shareButtonText, imageResource: ImageResource(name: viewModel.shareButtonImagePath, bundle: .main), action: {
            viewModel.onShareTapped()
        })
    }

    private var forgroundImage: some View {
        Image(viewModel.theme.backgroundImagePath)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BirthdayView(viewModel: BirthdayViewModel())
}
