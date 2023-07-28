////
////  RequestAPIYouTubeBigBox.swift
////  Ahreum
////
////  Created by Gaeun Lee on 2023/07/28.
////
//
//import Foundation
//
//class RequestAPIYouTubeBigBox: ObservableObject {
//    static let shared = RequestAPIYouTubeBigBox()
//    private init() {
//        fetchData()
//    }
//    @Published var YouTubeBigBoxList = [YouTubeBigBoxModel]()
//    
//    func fetchData(){
//        let id = UserDefaultManager.shared.id
//        let postData = PostData1(user_id: id, keyword: <#T##String#>)
//        APIManager().sendPostRequest(data: postData, url: "http://digooo.shop:5000/user-api") { result in
//            switch result {
//            case .success(let data):
//                if let responseString = String(data: data, encoding: .utf8) {
//                    print("Response: \(responseString)")
//                }
//                // Handle successful response here.
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//                // Handle error here.
//            }
//        }
//////      #if DEBUG
//////      YouTubeBigBoxList = [YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel()]
//////      #else
////        self.YouTubeBigBoxList = [YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel()]
////        guard let url = URL(string: "http://172.17.127.90:5000/test") else{
////            return
////        }
////        let session = URLSession(configuration: .default)
////
////        let task = session.dataTask(with: url) { data, response, error in
////            if let error = error{
////                print(error.localizedDescription)
////                return
////            }
////            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
////                return
////            }
////            guard let data = data else{
////                return
////            }
////            do{
////                let apiResponse = try JSONDecoder().decode(YouTubeBigBoxResults.self, from: data)
////                DispatchQueue.main.async {
////                    self.YouTubeBigBoxList = apiResponse.YouTubeBigBoxs
////                }
////            }catch(let err){
////                print(err.localizedDescription)
////            }
////        }
////        task.resume()
//////        #endif
//    }
//}
