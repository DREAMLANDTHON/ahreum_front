//
//  RequestAPIYouTubeBigBox.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import Foundation

class RequestAPIYouTubeBigBox: ObservableObject {
    static let shared = RequestAPIYouTubeBigBox()
    private init() {
        fetchData()
    }
    @Published var YouTubeBigBoxList = [YouTubeBigBoxModel]()
    
    func fetchData(){
//      #if DEBUG
//      YouTubeBigBoxList = [YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel()]
//      #else
        self.YouTubeBigBoxList = [YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel(), YouTubeBigBoxModel()]
        guard let url = URL(string: "http://172.17.127.90:5000/test") else{
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let data = data else{
                return
            }
            do{
                let apiResponse = try JSONDecoder().decode(YouTubeBigBoxResults.self, from: data)
                DispatchQueue.main.async {
                    self.YouTubeBigBoxList = apiResponse.YouTubeBigBoxs
                }
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        task.resume()
//        #endif
    }
}
