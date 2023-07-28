//
//  YouTubeDetailBoxView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct YouTubeDetailBoxView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isLoading = true
    @StateObject private var network = RequestAPIYouTubeDetailBox.shared
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Text("Xmark")
                    .onTapGesture {
                        dismiss()
                    }
            }
            let model = network.youTubeDetailBoxModel
            if let url = URL(string: model.url) {
                WebView(url: url, isLoading: $isLoading)
                    .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .overlay {
                        if isLoading {
                            Image("loadingBack").resizable()
                                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                                .overlay {
                                    ProgressView()
                                }
                        }
                    }
                    .padding(.bottom, 10)
            } else {
                Image("tempImage").resizable()
                    .frame(width: 160, height: 90)
                    .cornerRadius(10)
            }
            Text(model.title)
                .alignment(.leading)
                .padding(.bottom, 3)
            Text(model.description)
                .font(.caption)
                .alignment(.leading)
                .foregroundColor(.gray_)
            ScrollView(showsIndicators: false) {
                ForEach(model.commentList, id: \.self) { comment in
                    Text(comment)
                        .alignment(.leading)
                        .padding(.bottom, 10)
                }
            }
            Spacer()
        }
        .paddingHorizontal()
    }
}

struct YouTubeDetailBoxView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeDetailBoxView()
    }
}
