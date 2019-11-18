//
//  Model.swift
//  BubbleTalk
//
//  Created by 한수현 on 18/11/2019.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation
class Model {
    private let maxNumofBubbles: Int = 1000
    init() {
        print("model initialize")
    }
    func makeNewBubble (txt: String) -> Bubble{
        let newBubble = Bubble(text: txt, size: txt.count, id: getId())
        return newBubble
    }
    
    private func getId() -> Int{
        return Int(arc4random_uniform(UInt32(maxNumofBubbles)))
    }

}


