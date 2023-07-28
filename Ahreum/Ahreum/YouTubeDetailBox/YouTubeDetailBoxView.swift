//
//  YouTubeDetailBoxView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

class RequestAPIYouTubeDetailBox: ObservableObject {
    static let shared = RequestAPIYouTubeDetailBox()
    private init() {
    }
    @Published var youTubeDetailBoxModel = YouTubeDetailBoxModel()
    
    func fetchData(movieID: String) {
            let id = UserDefaultManager.shared.id
            let postData2 = PostData2(user_id: id, movie_id: movieID)
            APIManager().sendPostRequest2(data: postData2, url: "http://digooo.shop:5000/user-api") { result in
                switch result {
                case .success(let data):
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response44: \(responseString)")
                        
                        do{
                            let apiResponse = try JSONDecoder().decode(YouTubeDetailBoxResult.self, from: data)
                            DispatchQueue.main.async {
                                self.youTubeDetailBoxModel = apiResponse.YouTubeDetailBoxResult
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
//        guard let url = URL(string: "http://172.17.127.90:5000/detail") else {
//            return
//        }
//
//        let session = URLSession(configuration: .default)
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
//                let apiResponse = try JSONDecoder().decode(YouTubeDetailBoxResult.self, from: data)
//                DispatchQueue.main.async {
//                    self.youTubeDetailBoxModel = apiResponse.YouTubeDetailBoxResult
//                }
//            }catch(let err){
//                print(err.localizedDescription)
//            }
//        }
//        task.resume()
////        #endif
    }
}


struct YouTubeDetailBoxView: View {
    @Environment(\.dismiss) private var dismiss
    @State var nowBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 0
    @State var todayBallCount = UserDefaultManager.shared.getTodayBallCount() ?? 0
    @State var isLoading = true
    @State var isShowAlert = false
    @State var isdetaileViewClipped = true
    @Binding var isSearched: Bool
    let movieID: String
    @StateObject private var network = RequestAPIYouTubeDetailBox.shared
    
    var body: some View {
        ZStack() {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.backward")
                        .onTapGesture {
                            isShowAlert = true
                        }
                        .onAppear {
                            UserDefaultManager.shared.addUsingBallCount()
                            nowBallCount = UserDefaultManager.shared.getUsingBallCount() ?? 0
                            network.fetchData(movieID: movieID)
                        }
                        .padding(.trailing, 20)
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 77, height: 27)
                        .padding(.vertical, 12)
                    Spacer()
                }
                .paddingHorizontal()
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
                ScrollView(showsIndicators: false) {
                    Text(model.title)
                        .titleBold17()
                        .alignment(.leading)
                        .padding(.bottom, 13)
                    Text(model.description)
                        .bodymedium12()
                        .lineSpacing(4)
                        .alignment(.leading)
                        .frame(height: isdetaileViewClipped ? 60 : nil)
                        .overlay(alignment: .bottomTrailing) {
                            if isdetaileViewClipped {
                                Text("더보기")
                                    .background(Color.grayF8)
                                    .bodymedium12()
                                    .onTapGesture {
                                        isdetaileViewClipped = false
                                    }
                            }
                        }
                        .padding()
                        .background(Color.grayF8)
                        .cornerRadius(10)
                        .animation(Animation.easeInOut(duration: 0.2), value: isdetaileViewClipped)
                        .padding(.bottom, 20)
                    VStack(spacing: 0) {
                        Text("댓글")
                            .alignment(.leading)
                            .buttonBold14()
                            .padding(.bottom, 20)
                        ForEach(model.commentList, id: \.self) { comment in
                            HStack(alignment: .top, spacing: 0) {
                                Image("icon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 15)
                                Text(comment)
                                    .alignment(.leading)
                                    .bodymedium12()
                                    .lineSpacing(4)
                                    .padding(.top, 3)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding()
                    .background(Color.grayF8)
                    .cornerRadius(10)
                }
                .paddingHorizontal()
                Spacer()
            }
            if isShowAlert {
                VStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        let remainBallCount = todayBallCount - nowBallCount
                        if remainBallCount == 0 {
                            Text("Ball이 남지 않았습니다.")
                        } else {
                            Text("Ball이 \(remainBallCount)개 남았습니다.")
                        }
                        HStack(spacing: 0) {
                            if remainBallCount != 0 {
                                Button {
                                    dismiss()
                                } label: {
                                    Text("예")
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 12)
                                        .background(Color(hex: "E9E9E9"))
                                        .cornerRadius(10)
                                        .padding(.trailing, 8)
                                }
                            }
                            Button {
                                dismiss()
                                isSearched = false
                            } label: {
                                Text("홈으로 돌아가기")
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal, 37)
                                    .padding(.vertical, 12)
                                    .background(Color.Orange)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 44)
                    }
                    .padding(40)
                    .background(Color.white)
                    .cornerRadius(13)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "4B4B4B")?.opacity(0.9))
                .ignoresSafeArea()
            }
        }
    }
}

struct YouTubeDetailBoxView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeDetailBoxView(isSearched: .constant(false), movieID: "asdads")
    }
}
