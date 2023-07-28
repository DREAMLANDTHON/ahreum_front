//
//  SearchResultView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

class RequestAPIYouTubeBigBox: ObservableObject {
    static let shared = RequestAPIYouTubeBigBox()
    private init() {
    }
    @Published var YouTubeBigBoxList = [YouTubeBigBoxModel]()
    
    func fetchData(keyword: String){
        let id = Utils.getDeviceUUID()
        let postData = PostData1(user_id: id, keyword: keyword)
        APIManager().sendPostRequest1(data: postData, url: "http://digooo.shop:5000/videoList") { result in
            switch result {
            case .success(let data):
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response33: \(responseString)")
                    
                    do{
                        let apiResponse = try JSONDecoder().decode(YouTubeBigBoxResults.self, from: data)
                        DispatchQueue.main.async {
                            self.YouTubeBigBoxList = apiResponse.YouTubeBigBoxs
                        }
                    }catch(let err){
                        print(err.localizedDescription)
                    }
                }
                // Handle successful response here.
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                // Handle error here.
            }
        }
////      #if DEBUG
////      YouTubeBigBoxList = [YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel()]
////      #else
//        self.YouTubeBigBoxList = [YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel()]
//        guard let url = URL(string: "http://172.17.127.90:5000/test") else{
//            return
//        }
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error{
//                print(error.localizedDescription)
//                return
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                return
//            }
//            guard let data = data else{
//                return
//            }
//            do{
//                let apiResponse = try JSONDecoder().decode(YouTubeBigBoxResults.self, from: data)
//                DispatchQueue.main.async {
//                    self.YouTubeBigBoxList = apiResponse.YouTubeBigBoxs
//                }
//            }catch(let err){
//                print(err.localizedDescription)
//            }
//        }
//        task.resume()
////        #endif
    }
}


struct SearchResultView: View {
    
    @StateObject private var network = RequestAPIYouTubeBigBox.shared
    @State var isShowDetailBoxView = false
    @State var todayBallCount = UserDefaultManager.shared.getTodayBallCount() ?? 5
    @State var usingBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 2
    @State var selectedMovieID: String = ""
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
                            network.fetchData(keyword: searchText)
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
                if network.YouTubeBigBoxList.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(network.YouTubeBigBoxList, id: \.self) { model in
                            YouTubeBigBoxView(model: model)
                                .onTapGesture {
                                    isShowDetailBoxView = true
                                    selectedMovieID = model.movieID
                                }
                        }
                    }
                }
            }.fullScreenCover(isPresented: $isShowDetailBoxView) {
                YouTubeDetailBoxView(isSearched: $isSearched, movieID: selectedMovieID)
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
