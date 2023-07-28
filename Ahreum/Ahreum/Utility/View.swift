//
//  View.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

extension View {
    func paddingHorizontal() -> some View {
        self
            .padding(.horizontal, 27)
    }
    func ImageView(url: URL, width: CGFloat, height: CGFloat) -> some View {
        AsyncImage(url: url) { image in
                image.resizable()
                    .frame(width: width, height: height)
            } placeholder: {
                Image("loadingBack").resizable()
                    .frame(width: width, height: height)
                    .overlay {
                        ProgressView()
                    }
            }
    }
    func alignment(_ position: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
