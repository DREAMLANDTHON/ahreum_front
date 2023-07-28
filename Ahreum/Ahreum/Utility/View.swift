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
    func ImageView(url: URL) -> some View {
        AsyncImage(url: url) { image in
                image.resizable()
                .scaledToFill()
            } placeholder: {
                Image("loadingBack").resizable()
                    .scaledToFill()
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

class Utils {
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
