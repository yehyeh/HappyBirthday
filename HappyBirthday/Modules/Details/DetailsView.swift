//
//  DetailsView.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 25/04/2024.
//

import SwiftUI
import SwiftData

struct DetailsView: View {
    private let name = "Champ Name"
    private let birthdate = "Birthday"
    private let picture = ""
    private var pictureURL: URL? { URL(string: picture) }

    var body: some View {
        NavigationSplitView {

            Spacer()
            VStack(alignment: .center) {
                
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(birthdate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
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

                NavigationLink {
                    Text("\(name)'s Birthday!")
                } label: {
                    Text("Show birthday screen")
                }
            }
            .padding(.leading, 8)

            Spacer()
        } detail: {
            Text("Happy Birthday!")
        }
    }

    @ViewBuilder
    static private func picture(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
    }

    @ViewBuilder
    static private var picturePlaceholder: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
    }
}

#Preview {
    DetailsView()
        .modelContainer(for: Item.self, inMemory: true)
}
