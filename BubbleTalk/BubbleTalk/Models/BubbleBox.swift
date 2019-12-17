//
//  BubbleBox.swift
//  BubbleTalk
//
//  Created by 수진 on 02/12/2019.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation


class BubbleBox{
    var bubbles = [Bubble]()
    

    private let maxNumofBubbles: Int = 50
    init() {
        bubbles.append(Bubble(text: "", type: 0, id: 0))
        self.bubbles = parse()
        
        print("model initialize")
    }



//    private func show() -> [Bubble] {
//        return bubbles
//    }

    func add( a : Bubble ) {
        //load time and save with timestamp
        if(bubbles.count < maxNumofBubbles){
        _ = getTime()
        bubbles.append(a)
        }else { print("full capacity!") }

    }

   func delete( a : Bubble) {
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

    func exportToJson() {

        let jsonEncoder = JSONEncoder()
        if let tempData = try? jsonEncoder.encode(bubbles) {
//            let path = "/BubbleTalk/JSONSample/test.json"
//            let pathAsURL = URL(fileURLWithPath: path)
            
            let pathAsURL = Bundle.main.url(forResource: "test", withExtension: "json")!
            
            do{
                try tempData.write(to: pathAsURL)
            }
            catch{
                print("error \(error).")
            }
            print(pathAsURL)
        }
        
//        do {let fileURL = try FileManager.default.url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("test.json")
//            try JSONSerialization.data(withJSONObject: tempData).write(to: fileURL)}
//        catch {
//            print(error)
//        }

        //Create JSON
//        var Finaldata: Any?
//        if let data = tempData { Finaldata = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) }
//        print(String(data: tempData!, encoding: .utf8)!);
//
//        let file = "test.json" //this is the file. we will write to and read from it
//
//        let text = String(data: tempData!, encoding: .utf8)! //just a text
        
        
//        let desktop = URL(fileURLWithPath: "../BubbleTalk/JSONSample")
//        do {
//            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: desktop, create: true)
//
//           // let fileURL = dir.appendingPathComponent(file)
//
//            //writing
//
//            try text.write(to: desktop, atomically: false, encoding: .utf8)
//            }
//            catch {/* error handling here */}


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

    func parse() -> [Bubble]! {
           let jsonFile = "test"
           guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json")
            else {
                
                return [Bubble]()
        }
          guard let data = try? Data(contentsOf: url)
            else {
                return [Bubble]()
                
        }
         
        guard let output = try? JSONDecoder().decode([Bubble].self, from: data)
            else {
                return [Bubble]()
        }
            //else {
             //  throws print("no file")
        //newbubblebox = BubbleBox(bubbles:output)
        //newbubblebox.append()
            
        print(output, "here")
            //output type : bubble array(bubbles)
        return output
        }
    }

    //test.json
    




    //mutating func JsonDecode(){
        //var jsonString = String(data: tempData , encoding: .utf8)
        //print(jsonString)

        //let jsonFile = filename.data(using: .utf8)! //filename or jsonString
        //let decoder = JSONDecoder()
        //do {
        //    let bubbles = try decoder.decode([Bubble].self, from:jsonFile){
        //     print(bubbles)
        //      }
        //    }

    //}

        








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
