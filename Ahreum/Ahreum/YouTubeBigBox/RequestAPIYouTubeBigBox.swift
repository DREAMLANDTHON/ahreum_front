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
        
        print("1")
        guard let url = URL(string: "https://digooo.shop:5000/test") else{
            return
        }
        print("2")
        let session = URLSession(configuration: .default)
        
        print("3")
        let task = session.dataTask(with: url) { data, response, error in
            print("4")
            if let error = error{
                print(error.localizedDescription)
                return
            }
            print("5")
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.YouTubeBigBoxList = []
                return
            }
            print("6")
            guard let data = data else{
                return
            }
            print("7")
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
