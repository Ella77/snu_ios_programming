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
    var bubbleKeys: [Bubble]
    
    init(bubbleCollection: BubbleCollection) {
        for bubble in bubbleCollection.bubbles {
            bubbleView[bubble] = OneBubble(bubText: bubble.text, bubType: bubble.size)
        }
        bubbleKeys = bubbleView.keys.map { $0 }
    }
    
    mutating func bubbleViewUpdate(bubble bub: Bubble) {
        bubbleView[bub] = OneBubble(bubText: bub.text, bubType: bub.size)
        bubbleKeys.append(bub)
    }
    
    var body: some View {
        Group {
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                VStack {
                    ForEach(bubbleKeys) { key in
                        Spacer()
                        self.bubbleView[key]
                        Spacer()
                    }
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

// Bubble 2열로 배치하기 위한 프로토콜
protocol splitArrayProps {
    var bubbleKeysFirstRow: [Bubble] { get set }
    var bubbleKeysSecondRow: [Bubble] { get set }
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
        if (self.count == 1) {
            return halfOfSelf
        } else {
            for i in (self.count/2..<self.count) {
                halfOfSelf.append(self[i])
            }
        }
        return halfOfSelf
    }
}
