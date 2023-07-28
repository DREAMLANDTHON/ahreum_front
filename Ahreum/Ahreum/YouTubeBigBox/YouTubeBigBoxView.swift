//
//  YouTubeBigBoxView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct YouTubeBigBoxView: View {
    let model: YouTubeBigBoxModel
    
    init(model: YouTubeBigBoxModel = YouTubeBigBoxModel()) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                if let url = URL(string: model.image) {
                    ImageView(url: url)
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .cornerRadius(10)
                } else {
                    Image("tempImage").resizable()
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .cornerRadius(10)
                }
                Text(model.lengthTime)
                    .padding(.horizontal,5)
                    .padding(.vertical,2)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding([.bottom, .trailing], 5)
            }
            .padding(.trailing, 5)
            
            VStack(spacing: 0) {
                Text(model.title)
                    .alignment(.leading)
                    .buttonBold12()
                    .padding(.top, 8)
                Text(model.channelName)
                    .buttonBold12()
                    .alignment(.leading)
                    .padding(.top, 5)
                    .foregroundColor(Color(hex: "C0C0C0"))
            }
            .padding(.horizontal, 6)
            .alignment(.topLeading)
        }
        .padding(.horizontal, 20)
    }
}

struct YouTubeBigBoxView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeBigBoxView()
    }
}
