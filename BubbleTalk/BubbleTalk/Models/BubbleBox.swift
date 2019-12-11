//
//  BubbleBox.swift
//  BubbleTalk
//
//  Created by 수진 on 02/12/2019.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation


struct BubbleBox{
     var bubbles = [Bubble]()
    private let maxNumofBubbles: Int = 50
     init() {
        print("model initialize")
    }
    
    private func show() -> [Bubble] {
        return bubbles
    }
    
    mutating func add( a : Bubble ) -> Bubble {
        //load time and save with timestamp
        _ = getTime()
        bubbles.append(a)
        
        
        
    }
    mutating func delete( a : Bubble) -> Bubble {
        bubbles.remove(at:0)
        //
        
    }
    private func getTime()-> String{
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        print(formatter.string(from: currentDateTime))
        return formatter.string(from: currentDateTime)
        //return present's time step when adding
    }
    
    private func getCount()->Int{
        //get total number of bubbles in bubblebox
        return BubbleBox.bubbles.count
    }
    
    private func getOldestBubbles() -> Bubble{
        return bubbles[0]
    }
    
//    private func reachMaxBubbles() -> Bool {
//     //alert and delete oldest bubble
//        if (getCount() > maxNumofBubbles){
//            k = getOldestBubbles()
//            bubbles.remove(k)
//            //index 를 앞으로 땡기기 혹은 queue사용
//            return true
//        }
//        else {
//            return false
//        }
    }
  
}
