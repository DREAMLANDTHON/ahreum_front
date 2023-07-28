//
//  YouTubeBigBoxModel.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import Foundation

struct YouTubeBigBoxResults: Decodable {
    let YouTubeBigBoxs: [YouTubeBigBoxModel]
}

struct YouTubeBigBoxModel: Decodable, Hashable{
    let image: String
    let lengthTime: String
    let title: String
    let channelName: String
    
    init(image: String = "https://i.ytimg.com/vi/3yluDg_GnfE/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB-NoAzWEK-9CdzznuxAmXv6r0Vdw",
         lengthTime: String = "9:33",
         title: String = "가데이터입니다. 5분 명상 | 아침명상, 아침 스트레칭",
         channelName: String = "에일린 mind yoga") {
        self.image = image
        self.lengthTime = lengthTime
        self.title = title
        self.channelName = channelName
    }
}
