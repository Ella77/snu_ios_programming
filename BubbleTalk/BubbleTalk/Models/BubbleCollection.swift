//
//  BubbleCollection.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation
// View test하기 위해 임시로 만들었습니다. 모델 만드신 걸로 바꿔주세요!
struct BubbleCollection {
    var bubbles = [Bubble]()
    
    //테스트용
    var randomText = [
        "크리스마스라니!", "나 오늘 저녁 뭐 먹지?", "난 고양이보다 강아지가 좋아", "헐 진짜?", "이제 너무 추운 것 같아", "가나다라바사", "인터페이스 프로그래밍 5조", "징글벨 징글벨 징글 올 더 웨이~"
    ]
    
    mutating func bubbleAppend(bubble: Bubble) {
        bubbles.append(bubble)
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
