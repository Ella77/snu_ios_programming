//
//  ReceivedBubbles.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/22.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct ReceivedBubbles: View {
    var bubbleBox: BubbleBox
    
    //optional로 바꿀 것
    private var bubbleView = [Bubble: OneBubble]()
    var bubbleKeys: [Bubble]
    private var recentlyAddedBubbleKey: Bubble?
    
    init(bubbleCollection: BubbleManager, bubbleBox: BubbleBox) {
        for bubble in bubbleCollection.bubbles {
//            bubbleView[bubble] = OneBubble(bubText: bubble.text, bubType: bubble.type, bubbleBox: bubbleBox)
//        }
             bubbleView[bubble] = OneBubble(bubble: bubble, bubbleBox: bubbleBox)
        }
        bubbleKeys = bubbleView.keys.map { $0 }
    
        self.bubbleBox = bubbleBox
    }
    
    mutating func bubbleViewUpdate(bubble: Bubble) {
//         최대 20개 띄울 수 있게
        if (bubbleKeys.count >= 20) {
            bubbleKeys.remove(at: 0)
        }
        if let bubbleKey = recentlyAddedBubbleKey {
            bubbleView[bubbleKey]?.unmarkLastAdded()
        }
        
        bubbleView[bubble] = OneBubble(bubble: bubble, bubbleBox: bubbleBox)
//        bubbleView[bubble] = OneBubble(bubble: bubble bubText: bubble.text, bubType: bubble.type, bubbleBox: bubbleBox)
        bubbleKeys.append(bubble)
        
        recentlyAddedBubbleKey = bubble

    }
    
    var body: some View {
        ZStack {
           
                ForEach(self.bubbleKeys) { key in
                    self.bubbleView[key]
                        .animation(self.bubbleView[key]!.lastAdded ? Animation.spring(response: 3, dampingFraction: 0.56, blendDuration: 1 ) : Animation.default)
                        .shadow(color: self.bubbleView[key]!.lastAdded ? .blue : .clear, radius: 1)
                    
                        
                }
            

        }
            .background(
            Image("background")
                .aspectRatio(contentMode: .fill)
        )
    }
}

//struct ReceivedBubbles_Previews: PreviewProvider {
//    static var previews: some View {
//        ReceivedBubbles(bubbleCollection: BubbleManager())
//    }
//}

// Bubble 2열로 배치하기 위한 프로토콜
//protocol splitArrayProps {
//    var bubbleKeysFirstRow: [Bubble] { get set }
//    var bubbleKeysSecondRow: [Bubble] { get set }
//}
//// array 절반 쪼개기
//extension Array {
//    var splitFirstHalf: Array {
//        var halfOfSelf: Array = []
//        for i in (0..<self.count/2) {
//            halfOfSelf.append(self[i])
//        }
//        return halfOfSelf
//    }
//    var splitSecondHalf: Array {
//        var halfOfSelf: Array = []
//        if (self.count == 1) {
//            return halfOfSelf
//        } else {
//            for i in (self.count/2..<self.count) {
//                halfOfSelf.append(self[i])
//            }
//        }
//        return halfOfSelf
//    }
//}


