//
//  ContentView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct ContentView: View {
    @State var todayBallCount: Int
    @State var isFirstComeToday: Bool
    @State var searchText: String = ""
    @FocusState private var isKeyBoardOn: Bool
    
    init() {
        if let todayBallCount = UserDefaultManager.shared.getTodayBallCount() {
            self.todayBallCount = todayBallCount
            self.isFirstComeToday = false
        } else {
            self.todayBallCount = 5
            self.isFirstComeToday = true
        }
    }
    
    var body: some View {
        VStack {
            Text("오늘의 챌린지")
                .alignment(.leading)
            if isFirstComeToday {
                Image("Phong")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("오늘은 몇 회까지 제한을 둘까요?")
                HStack {
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
            }
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
    private func NavigationView() -> some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .padding(.trailing, 7)
                .foregroundColor(.black_)
            TextField("검색", text: $searchText)
                .submitLabel(.done)
                .focused($isKeyBoardOn)
                .onAppear {
                    isKeyBoardOn = true
                }
            if searchText != "" {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 10)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
