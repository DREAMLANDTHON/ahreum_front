//
//  ContentView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct ContentView: View {
    @State var todayBallCount: Int
    @State var usingBallCount: Int
    @State var isFirstComeToday: Bool
    @State var isShowSearchView: Bool
    @State var searchText: String = ""
    @State var isSearched = false
    @FocusState private var isKeyBoardOn: Bool
    
    init() {
        //TODO: 삭제해야함
        UserDefaultManager.shared.resetAllUserDefault()
        
        if let todayBallCount = UserDefaultManager.shared.getTodayBallCount() {
            self.todayBallCount = todayBallCount
            self.usingBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 0
            self.isFirstComeToday = false
        } else {
            self.todayBallCount = 5
            self.usingBallCount = 0
            self.isFirstComeToday = true
        }
        self.isShowSearchView = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView()
            if isSearched {
                SearchResultView(isSearched: $isSearched)
            } else {
                TodayChallenge()
                VStack(spacing: 0) {
                    Text("내가 만드는 알고리즘")
                        .alignment(.leading)
                    Text("나는 이런 것들을 좋아하는 구나!")
                        .alignment(.leading)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            Spacer()
        }
        .foregroundColor(.black_)
        .paddingHorizontal()
    }
}

extension ContentView {
    @ViewBuilder
    private func ballTicket(number: Int) -> some View {
        Circle()
            .frame(width: 25, height: 25)
            .overlay {
                Text("\(number)")
                    .foregroundColor(.white)
            }
    }
    @ViewBuilder
    private func TodayChallenge() -> some View {
        VStack(spacing: 0) {
            Text("오늘의 챌린지")
                .alignment(.leading)
            HStack(spacing: 0) {
                Image("Phong")
                    .resizable()
                    .frame(width: 120, height: 120)
                VStack(spacing: 0) {
                    Text(isFirstComeToday ? "몇 회까지 제한을 둘까요?" : "김써머님")
                        .foregroundColor(.black_)
                        .alignment(.leading)
                        .padding(.bottom, 20)
                    if isFirstComeToday {
                        HStack(spacing: 0) {
                            ForEach(1...6, id: \.self) { num in
                                ballTicket(number: num)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        UserDefaultManager.shared.saveTodayBallCount(num: num)
                                        todayBallCount = num
                                        isFirstComeToday = false
                                    }
                            }
                        }
                    } else {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text("총 사용 Ticket")
                                    .padding(.bottom, 10)
                                Text("\(todayBallCount)개")
                            }
                            .padding(.trailing, 20)
                            
                            VStack(spacing: 0) {
                                Text("남은 Ticket")
                                    .padding(.bottom, 10)
                                Text("\(todayBallCount - usingBallCount)개")
                            }
                        }
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.2))
        .padding()
    }
    @ViewBuilder
    private func NavigationView() -> some View {
        HStack(spacing: 0) {
            if !isFirstComeToday {
                if isShowSearchView {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 7)
                    .foregroundColor(.black_)
                TextField("검색", text: $searchText)
                    .submitLabel(.done)
                    .focused($isKeyBoardOn)
                if searchText != "" {
                    Button(action: {
                        isSearched = false
                    }) {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 10)
                    }
                }
                }
            }
        }
        .onChange(of: isSearched, perform: { newValue in
            if newValue == false {
                searchText = ""
            }
            todayBallCount = UserDefaultManager.shared.getTodayBallCount() ?? 0
            usingBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 0
            
            if todayBallCount - usingBallCount <= 0 {
                isKeyBoardOn = false
                isShowSearchView = false
                isSearched = false
            }
        })
        .onChange(of: isKeyBoardOn, perform: { newValue in
            isSearched = true
        })
        .padding(.horizontal, 10)
        .padding(.vertical, 9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
