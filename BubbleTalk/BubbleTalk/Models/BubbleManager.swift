//
//  Model.swift
//  BubbleTalk
//
//  Created by 한수현 on 18/11/2019.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//
import UIKit

import Foundation

struct BubbleManager {
    var bubbles = [Bubble]()

    
    private let maxNumofBubbles: Int = 1000
    init() {
        print("model initialize")
    }
    mutating func makeNewBubble (txt: String) -> Bubble{
        var sz: Int { return txt.count < 10 ? 1 : 2 }
        let newBubble = Bubble(text: txt, size: sz, id: getId())
        
        //if you want to set color randomly and set x,y coordinate randomly
        //let newBubble = Bubble(text: txt, size: txt.count, id: getId(),color:getColor(),x:getX(),y:getY())
        bubbles.append(newBubble)
        return newBubble
    }
    
    private func getId() -> Int{
        return maxNumofBubbles.arc4random
    }
    
//    private func getColor() -> UIColor {
//        return  UIColor(red: .random(in: 0...1),
//                        green: .random(in: 0...1),
//                        blue: .random(in: 0...1),
//                        alpha: 1.0)
//    }
    
    
    // you need to set talk chat zone's relative ratio for ViewHeight, ViewWidth 
    
    // a random number in the range 0 - ViewHeight and 0 - ViewWidth respectively
//    let screen = UIScreen.main.bounds
//    let screenWidth = screen.size.width //needs to multiply some ratio
//    let screenHeight = screen.size.height  //needs to multiply some ratio
//    private func getX() -> CGFloat{
//        return CGFloat(arc4random_uniform(UInt32(0..screenWidth)))
//    }
//    private func getY() -> CGFloat{
//        return CGFloat(arc4random_uniform(UInt32(0..screenHeight)))
//    }

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
