//
//  ContentView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var network = RequestAPI.shared
    
    var body: some View {
        VStack {
            Text("아름")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            ScrollView(showsIndicators: false) {
                ForEach(network.YouTubeBigBoxList, id: \.self) { model in
                    YouTubeBigBoxView(model: model)
                }
            }
        }
        .paddingHorizontal()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
