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
    
    mutating func exportToJson() {
    
        let jsonEncoder = JSONEncoder()
        let tempData = try? jsonEncoder.encode(bubbles)
        
        //Create JSON
        var Finaldata: Any?
        if let data = tempData { Finaldata = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) }
        print(String(data: tempData!, encoding: .utf8)!);
        
        let file = "test.json" //this is the file. we will write to and read from it

        let text = String(data: tempData!, encoding: .utf8)! //just a text
        let desktop = URL(fileURLWithPath: "../BubbleTalk/JSONSample")
        do {
            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: desktop, create: true)

           // let fileURL = dir.appendingPathComponent(file)

            //writing
            
            try text.write(to: desktop, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}

        
//        do {
//            let fileURL = try FileManager.default
//                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                .appendingPathComponent("example.json")
//
//            try JSONSerialization.data(withJSONObject: Finaldata)
//                .write(to: fileURL)
//        } catch {
//            print(error)
//        }
        
        
        


   }
    
        func importToBox() {
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

  




//// struct renewal for json encoding
//struct BubbleBox: Encodable, ExpressibleByArrayLiteral {
//    var bubbles = [Bubble]()
//
//    typealias ArrayLiteralElement = Bubble
//
//    init(arrayLiteral elements: Bubble...) {
//        bubbles = elements
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        for (i, photo) in bubbles.enumerated() {
//            try container.encode(photo, forKey: CodingKeys(stringValue: "bubble\(i + 1)")!)
//        }
//       //TODO CodingKeys("bubble1"...) when var bubble1 = Bubble()

//    }
//
//    struct CodingKeys: CodingKey, ExpressibleByStringLiteral {
//        var stringValue: String { return key }
//
//        init?(stringValue: String) {
//            key = stringValue
//        }
//
//        var intValue: Int? { return Int(key) }
//
//        init?(intValue: Int) {
//            key = "\(intValue)"
//        }
//
//        init(stringLiteral value: String) {
//            key = value
//        }
//
//        var key: String
//    }
//}

