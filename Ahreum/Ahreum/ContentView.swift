//
//  ContentView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var network = RequestAPIYouTubeBigBox.shared
    @State var isShowDetailBoxView = false
    
    var body: some View {
        VStack {
            Text("아름")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            YouTubeDetailBoxView()
            ScrollView(showsIndicators: false) {
                ForEach(network.YouTubeBigBoxList, id: \.self) { model in
                    YouTubeBigBoxView(model: model)
                        .onTapGesture {
                            isShowDetailBoxView = true
                        }
                }
            }
        }
        .fullScreenCover(isPresented: $isShowDetailBoxView) {
            YouTubeDetailBoxView()
        }
        .foregroundColor(.black_)
        .paddingHorizontal()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
