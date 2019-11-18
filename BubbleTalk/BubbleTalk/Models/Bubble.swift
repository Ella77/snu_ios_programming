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
    
    /*
     extension Bubble{
     var toJSON: Any{
        return [
            "text": text,
            "size": size
        ]
     }
     
     init?(fromJSON json: Any){
        guard
            let bubble = json as? [String: Any],
            let text = bubble["text"] as? String,
            let size = bubble["size"] as? Int
            else{
                print("Couldn't parse JSON")
                return nil
            }
     }
     */
    
    init(text txt: String, size sz: Int, id bubId: Int) {
        text = txt
        size = sz
        id = bubId
    }

    
}
