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
    
    
    
//    private func show() -> [Bubble] {
//        return bubbles
//    }
    
    mutating func add( a : Bubble ) {
        //load time and save with timestamp
        if(bubbles.count < maxNumofBubbles){
        _ = getTime()
        bubbles.append(a)
        }else { print("full capacity!") }
        
    }
    
    mutating func delete( a : Bubble) {
        let selectedBubble = bubbles.firstIndex(of: a)
        bubbles.remove(at: selectedBubble!)
        
        
        
    }
   
//    mutating func indexes(of item : Bubble) -> [Int] {
//            return bubbles.filter({ $0.element  == item }).map({ $0.offset })
//        // search by element
//        //usage : bubbles.indexes(of: Bubble~)
    
//     mutating func getindexes(of item : Bubble) -> Int {
//    let index = bubbles.firstIndex(where: { $0.id == item.id })
//        return index
    // search by bubble id
    // usage : bubbles.getindexes(of : Bubble~)
    
//    }


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
        return bubbles.count
    }
    
//    private func getOldestBubbles() -> Bubble{
//        return bubbles[0]
//    }
    
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
    
    mutating func exportToJson(from object: Any) {
//        let encoder = JSONEncoder()
//        for includedBubble in bubbles {
//            let jsonData = try? encoder.encode(includedBubble)
//
//        }
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: bubbles, options: .prettyPrinted)
//        print(String(data: jsonData, encoding: .utf8))
        
//       if let theJSONData = try?  JSONSerialization.data(withJSONObject: bubbles, options: .prettyPrinted),
//         let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
//             print("JSON string = \n\(theJSONText)")
        
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("bubblebox.json")

            try JSONSerialization.data(withJSONObject: bubbles, options: .prettyPrinted)
                .write(to: fileURL)
        } catch {
            print(error)
        }
   }
    
    mutating func importToBox() {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("bubblebox.json")

            let data = try Data(contentsOf: fileURL)
//            let foo = try JSONDecoder().decode(Foo.self, from: data)
//            print(foo)
        } catch {
            print(error)
        }
    }

    
  
}
