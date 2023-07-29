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
    @State var isTouchedSearchbar = false
    @State var isSearched = false
    @State var keywordList: [String] = []
    @FocusState private var isKeyBoardOn: Bool
    
    private let columns = [
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading)
    ]
    
    
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
            HStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 77, height: 27)
                    .padding(.vertical, 12)
                    .onTapGesture {
                        isShowSearchView = true
                        isTouchedSearchbar = false
                        isSearched = false
                    }
                NavigationView()
                Spacer()
            }
            .paddingHorizontal()
            dividerThick1
                .padding(.bottom, isSearched ? 15 : 45)
            if isSearched {
                SearchResultView(isSearched: $isSearched, searchText: $searchText)
            } else {
                TodayChallenge()
                VStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("내가 만든 알고리즘")
                            .titleBold20()
                            .alignment(.leading)
                            .padding(.leading, 5)
                            .padding(.top, 25)
                            .padding(.bottom, 15)
                        VStack {
                            Text("Ai가 분석한 김썸머의 맞춤 키워드")
                                .buttonBold12()
                                .foregroundColor(.Orange)
                                .padding(.bottom, 15)
                        }
                    }
                    .overlay(alignment: .topTrailing) {
                        Image("alert")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 13, height: 13)
                            .padding(.top, 20)
                    }
                    
                        VStack(alignment: .center, spacing: 0) {
                            if keywordList.isEmpty {
                                Spacer()
                                Text("Ai가 김썸머님의 관심 키워드를\n찾아줄 예정입니다!")
                                    .foregroundColor(Color.Orange)
                                    .bodymedium12()
                            } else {
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(keywordList, id: \.self) { keyword in
                                        HStack(alignment: .center, spacing: 0) {
                                            Spacer()
                                            Text(keyword)
                                                .alignment(.center)
                                                .buttonBold12()
                                                .foregroundColor(Color.white)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.top, 5)
                                        .padding(.bottom, 6)
                                        .background(Color.Orange)
                                        .cornerRadius(15)
                                        .padding(.horizontal, 5)
                                    }
                                }
                                .padding(15)
                            }
                            Spacer()
                        }
                    .frame(maxWidth: .infinity, maxHeight: 199)
                    .background(Color.grayF8)
                    .cornerRadius(10)
                    .onAppear {
                        // 호출 보내기
                        print("id", UserDefaultManager.shared.id)
                        let postData = PostData(user_id: UserDefaultManager.shared.id)
                        APIManager().sendPostRequest(data: postData, url: "http://digooo.shop:5000/keywords") { result in
                            switch result {
                            case .success(let data):
                                if let responseString = String(data: data, encoding: .utf8) {
                                    print("Response: \(responseString)")
                                    
                                    do{
                                        let apiResponse = try JSONDecoder().decode(keywords.self, from: data)
                                        DispatchQueue.main.async {
                                            self.keywordList = apiResponse.keyword
                                        }
                                    }catch(let err){
                                        print("Error2:\(err.localizedDescription)")
                                    }
                                }
                                // Handle successful response here.
                            case .failure(let error):
                                print("Error: \(error.localizedDescription)")
                                // Handle error here.
                            }
                        }
                    }
                }
                .paddingHorizontal()
            }
            Spacer()
        }
    }
}

struct keywords: Decodable {
    let keyword: [String]
}

extension ContentView {
    @ViewBuilder
    private func TodayChallenge() -> some View {
        VStack(spacing: 0) {
            Text("오늘의 챌린지")
                .titleBold20()
                .alignment(.leading)
                .padding(.bottom, 14)
                .padding(.leading, 5)
            HStack(spacing: 0) {
                Image("Phong")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 40)
                VStack(spacing: 0) {
                    Text(isFirstComeToday ? "몇 회까지 제한을 둘까요?" : "김써머님\n시간은 금! 아시죠?")
                        .titleBold17()
                        .foregroundColor(Color.Orange)
                        .alignment(.leading)
                        .padding(.bottom, 20)
                        .padding(.leading, 5)
                        .animation(Animation.easeInOut(duration: 0.5), value: isFirstComeToday)
                    if isFirstComeToday {
                        HStack(spacing: 0) {
                            ForEach(1..<6, id: \.self) { num in
                                ballTicket(number: num, color: Color.Orange, isNumber: true)
                                    .padding(.horizontal, 3)
                                    .onTapGesture {
                                        UserDefaultManager.shared.saveTodayBallCount(num: num)
                                        todayBallCount = num
                                        isFirstComeToday = false
                                    }
                            }
                            Spacer()
                        }
                    } else {
                        Text("남은 Ball")
                            .bodymedium12()
                            .alignment(.leading)
                            .padding(.bottom, 10)
                            .padding(.leading, 5)
                        HStack(spacing: 0) {
                            let remainBallCount = todayBallCount - usingBallCount
                            ForEach(0..<usingBallCount, id: \.self) { num in
                                ballTicket(number: num, color: Color.grayCC, isNumber: false)
                                    .foregroundColor(.grayCC)
                                    .padding(.horizontal, 3)
                            }
                            ForEach(0..<remainBallCount, id: \.self) { num in
                                ballTicket(number: num+1, color: Color.Orange, isNumber: true)
                                    .padding(.horizontal, 3)
                            }
                            Spacer()
                        }
                        .animation(Animation.easeInOut(duration: 0.2), value: isFirstComeToday)
                    }
                }
            }
            .background(Color.grayF8)
            .cornerRadius(10)
        }
        .paddingHorizontal()
    }
    @ViewBuilder
    private func NavigationView() -> some View {
        HStack(spacing: 0) {
            if !isFirstComeToday {
                if isShowSearchView {
                    TextField("", text: $searchText)
                        .submitLabel(.done)
                        .focused($isKeyBoardOn)
                        .padding(.leading, 10)
//                    if searchText != "" {
//                        Button(action: {
//                            isSearched = false
//                            searchText = ""
//                        }) {
//                            Image(systemName: "x.circle.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 16, height: 16)
//                                .padding(.trailing, 10)
//                                .foregroundColor(Color.Orange.opacity(0.8))
//                        }
//                    } else {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 7)
                            .onTapGesture {
                                if isTouchedSearchbar {
                                    isSearched = true
                                }
                                isTouchedSearchbar = true
//                            }
                    }
                            .animation(Animation.easeInOut(duration: 0.2), value: isTouchedSearchbar)
                }
            }
        }
        .padding(4)
        .background(Color.white)
        .cornerRadius(16)
        .padding(1)
        .background(isTouchedSearchbar ? Color.grayCC : .white )
        .cornerRadius(16)
        .padding(.leading, 28)
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
        .padding(.vertical, 9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
