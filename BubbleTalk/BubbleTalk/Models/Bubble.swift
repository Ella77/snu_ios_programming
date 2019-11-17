//
//  Bubble.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation
// View test하기 위해 임시로 만들었습니다. 모델 만드신 걸로 바꿔주세요!
struct Bubble: Hashable, Identifiable {
    var id: Int
    var text: String
    var size: Int
    
    init(text txt: String, size sz: Int, id bubId: Int) {
        text = txt
        size = sz
        id = bubId
    }
}
