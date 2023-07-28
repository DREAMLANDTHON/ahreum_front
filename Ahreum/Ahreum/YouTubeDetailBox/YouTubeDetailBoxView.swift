//
//  YouTubeDetailBoxView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct YouTubeDetailBoxView: View {
    @Environment(\.dismiss) private var dismiss
    @State var nowBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 0
    @State var todayBallCount = UserDefaultManager.shared.getTodayBallCount() ?? 0
    @State var isLoading = true
    @State var isShowAlert = false
    @State var isdetaileViewClipped = true
    @Binding var isSearched: Bool
    @StateObject private var network = RequestAPIYouTubeDetailBox.shared
    
    var body: some View {
        ZStack() {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Text("Xmark")
                        .onTapGesture {
                            isShowAlert = true
                        }
                        .onAppear {
                            UserDefaultManager.shared.addUsingBallCount()
                            nowBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 0
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
                    .frame(height: isdetaileViewClipped ? 60 : nil)
                    .overlay(alignment: .bottomTrailing) {
                        if isdetaileViewClipped {
                            Text("더보기")
                                .background(Color.white)
                                .onTapGesture {
                                    isdetaileViewClipped = false
                                }
                        }
                    }
                    .animation(Animation.easeInOut(duration: 0.2), value: isdetaileViewClipped)
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
            if isShowAlert {
                VStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        let remainBallCount = todayBallCount - nowBallCount
                        if remainBallCount == 0 {
                            Text("티켓이 남지 않았습니다.")
                        } else {
                            Text("티켓이 \(remainBallCount)개 남았습니다.")
                        }
                        HStack(spacing: 0) {
                            if remainBallCount != 0 {
                                Button {
                                    dismiss()
                                } label: {
                                    Text("예")
                                        .padding()
                                        .background(Color.gray_)
                                        .cornerRadius(10)
                                        .padding()
                                }
                            }
                            Button {
                                dismiss()
                                isSearched = false
                            } label: {
                                Text("홈으로 돌아가기")
                                    .padding()
                                    .background(Color.gray_)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(40)
                    .background(Color.white)
                    .cornerRadius(20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray_)
            }
        }
    }
}

struct YouTubeDetailBoxView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeDetailBoxView(isSearched: .constant(false))
    }
}
