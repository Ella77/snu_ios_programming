//
//  Model.swift
//  BubbleTalk
//
//  Created by 한수현 on 18/11/2019.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//
import UIKit
import Foundation
class Model {
    private let maxNumofBubbles: Int = 1000
    init() {
        print("model initialize")
    }
    func makeNewBubble (txt: String) -> Bubble{
        let newBubble = Bubble(text: txt, size: txt.count, id: getId())
        
        //if you want to set color randomly and set x,y coordinate randomly
        //let newBubble = Bubble(text: txt, size: txt.count, id: getId(),color:getColor(),x:getX(),y:getY())
        
        return newBubble
    }
    
    private func getId() -> Int{
        return Int(arc4random_uniform(UInt32(maxNumofBubbles)))
    }
    
    private func getColor() -> UIColor {
        return  UIColor(red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1),
                        alpha: 1.0)
    }
    /*
    // a random number in the range 0 - ViewHeight and 0 - ViewWidth respectively
    private func getX() -> CGFloat{
        return CGFloat(arc4random_uniform(UInt32(0..viewWidth)))
    }
    private func getY() -> CGFloat{
       return CGFloat(arc4random_uniform(UInt32(0..viewHeight)))
    }*/

}


