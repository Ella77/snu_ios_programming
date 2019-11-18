//
//  Bubble.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation
// View test하기 위해 임시로 만들었습니다. 모델 만드신 걸로 바꿔주세요!. id 값은 있어야합니다
struct Bubble: Hashable, Identifiable {
    var id: Int
    var text: String
    var size: Int
    
    init(text : String, size: Int, id: Int) {
        self.text = text
        self.size = size
        self.id = id
       
//        print(text,"initalize")
    }
}
