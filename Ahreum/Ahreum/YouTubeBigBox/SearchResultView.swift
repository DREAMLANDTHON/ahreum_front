//
//  SearchResultView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct SearchResultView: View {
    
    @StateObject private var network = RequestAPIYouTubeBigBox.shared
    @State var isShowDetailBoxView = false
    @State var todayBallCount = UserDefaultManager.shared.getTodayBallCount() ?? 5
    @State var usingBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 2
    @Binding var isSearched: Bool
    @Binding var searchText: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    let remainBallCount = todayBallCount - usingBallCount
                    
                    Spacer()
                        .onAppear {
                            print("remainBallCount", remainBallCount)
                        }
                    ForEach(0..<usingBallCount, id: \.self) { num in
                        ballTicket(number: num, color: Color.grayCC, isNumber: false, size: 13)
                            .foregroundColor(.grayCC)
                            .padding(.horizontal, 3)
                    }
                    if remainBallCount > 0 {
                        ForEach(0..<remainBallCount, id: \.self) { num in
                            ballTicket(number: num, color: Color.Orange, isNumber: false, size: 13)
                                .padding(.horizontal, 3)
                        }
                    }
                }
                .padding(.bottom, 13)
                .padding(.horizontal, 27)
                ScrollView(showsIndicators: false) {
                    ForEach(network.YouTubeBigBoxList, id: \.self) { model in
                        YouTubeBigBoxView(model: model)
                            .onTapGesture {
                                isShowDetailBoxView = true
                            }
                    }
                }
            }.fullScreenCover(isPresented: $isShowDetailBoxView) {
                YouTubeDetailBoxView(isSearched: $isSearched)
                    .onDisappear {
                        todayBallCount = UserDefaultManager.shared.getTodayBallCount() ?? 5
                        usingBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 2
                    }
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchResultView(isSearched: .constant(false), searchText:  .constant(""))
    }
}
