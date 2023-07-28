//
//  RequestAPIYouTubeDetailBox.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//
import SwiftUI

class RequestAPIYouTubeDetailBox: ObservableObject {
    static let shared = RequestAPIYouTubeDetailBox()
    private init() {
        fetchData()
    }
    @Published var youTubeDetailBoxModel = YouTubeDetailBoxModel()
    
    func fetchData(){
        
        guard let url = URL(string: "http://172.17.127.90:5000/detail") else {
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
                let apiResponse = try JSONDecoder().decode(YouTubeDetailBoxResult.self, from: data)
                DispatchQueue.main.async {
                    self.youTubeDetailBoxModel = apiResponse.YouTubeDetailBoxResult
                }
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        task.resume()
//        #endif
    }
}
