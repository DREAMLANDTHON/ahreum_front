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
    let title: String
    let movieID: String
    let channelName: String
    let url: String
    let description: String
    let commentList: [String]
    
    init(image: String = "https://i.ytimg.com/vi/3yluDg_GnfE/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB-NoAzWEK-9CdzznuxAmXv6r0Vdw",
         title: String = "가데이터입니다. 5분 명상 | 아침명상, 아침 스트레칭",
         movieID: String = "movieID",
         channelName: String = "에일린 mind yoga",
         description: String = "#최유리 #플레이리스트 #playlist\n🍀구독 ❤️좋아요 💬댓글은 큰 힘이 됩니다.\n⭐️이 영상의 저작권은 '최유리' 가수님에게 있습니다.\n⭐️이 영상은 수익을 창출하지 않습니다.\n⭐️최신 앨범 발매 순으로 정렬한 목록입니다.\n\n#최유리 #Choiyuri #싱어송라이터 #Singersongwriter #최유리 #Choiyuri #플레이리스트 #playlist #전곡",
         url: String = "https://www.youtube.com/embed/A52uLJwcYuo",
         commentList: [String] = ["노래들이 참 이쁘고 보석같다…감사합니다 좋은노래들 ^^", "최정훈의 밤의공연에서 처음 보고 알게되었는데 저도 모르게 자꾸 최유리님 감성에 매료되어 찾아보게 되네요. 노래를 듣고 있으몀 마음이 울어요"]) {
        self.image = image
        self.title = title
        self.movieID = movieID
        self.channelName = channelName
        self.url = url
        self.description = description
        self.commentList = commentList
    }
}
