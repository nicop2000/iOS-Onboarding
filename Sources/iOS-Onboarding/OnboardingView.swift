//
//  OnboardingView.swift
//
//
//  Created by Nico Petersen on 04.04.24.
//

import SwiftUI

struct OnboardingView: View {
    @State var selection: Int = 0
    var images: [UIImage]
    var onDismiss: () -> Void = {}
    var hasNext: Bool {
        selection < images.count - 1
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                TabView(selection: $selection) {
                    ForEach(Array(images.enumerated()), id: \.1) { index, image in
                        Image(uiImage: image)
                            .tag(index)
                    }
                }

                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))

                Button(hasNext ? "Weiter" : "Schließen") {
                    if hasNext {
                        withAnimation {
                            selection += 1
                        }
                    } else {
                        onDismiss()
                    }
                }
            }

            Button(action: {
                onDismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")

                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            })
            .padding(.trailing)
        }
    }
}

