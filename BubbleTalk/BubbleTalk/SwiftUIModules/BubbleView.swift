//
//  BubbleView.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleView: View {
    //optional로 바꿀 것
    private var bubbleView = [Bubble: OneBubble]()
    private var bubbleKeys: [Bubble] {
        return bubbleView.keys.map { $0 }
    }
    private var bubbleKeysFirstRow: [Bubble] {
        return bubbleKeys.splitFirstHalf
    }
    private var bubbleKeysSecondRow: [Bubble] {
        return bubbleKeys.splitSecondHalf
    }
    
    init(bubbleCollection: BubbleCollection) {
        for bubble in bubbleCollection.bubbles {
            bubbleView[bubble] = OneBubble(bubText: bubble.text, bubType: bubble.size)
        }
    }
    
//    mutating func bubbleViewUpdate(bubble bub: Bubble) {
//        bubbleView[bub] = OneBubble(bubText: bub.text, bubType: bub.size)
//    }
    
    var body: some View {
        Group {
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                VStack {
                    Spacer()
                    ForEach(bubbleKeysFirstRow) { key in
                        Spacer()
                        self.bubbleView[key]
                        Spacer()
                    }
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    ForEach(bubbleKeysSecondRow) { key in
                        Spacer()
                        self.bubbleView[key]
                        Spacer()
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct BubblesViewDrawing_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(bubbleCollection: BubbleCollection())
    }
}

// array 절반 쪼개기
extension Array {
    var splitFirstHalf: Array {
        var halfOfSelf: Array = []
        for i in (0..<self.count/2) {
            halfOfSelf.append(self[i])
        }
        return halfOfSelf
    }
    var splitSecondHalf: Array {
        var halfOfSelf: Array = []
        for i in (self.count/2..<self.count) {
            halfOfSelf.append(self[i])
        }
        return halfOfSelf
    }
}