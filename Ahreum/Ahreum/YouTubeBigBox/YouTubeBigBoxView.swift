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
        HStack(spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                if let url = URL(string: model.image) {
                    ImageView(url: url, width: 160, height: 90)
                        .cornerRadius(10)
                        
                } else {
                    Image("tempImage").resizable()
                        .frame(width: 160, height: 90)
                        .cornerRadius(10)
                }
                Text(model.lengthTime)
                    .font(.caption2)
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
                Text(model.channelName)
                    .alignment(.leading)
                    .foregroundColor(.gray_)
                Spacer()
            }
        }
    }
}

struct YouTubeBigBoxView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeBigBoxView()
    }
}
