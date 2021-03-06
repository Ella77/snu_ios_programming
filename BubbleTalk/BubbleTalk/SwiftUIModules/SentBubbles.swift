//
//  SentBubbles.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/22.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct SentBubbles: View {
    //optional로 바꿀 것
    private var bubbleView = [Bubble: OneBubble]()
    var bubbleKeys: [Bubble]
    var bubbleBox: BubbleBox
    
    init(bubbleCollection: BubbleManager, bubbleBox: BubbleBox) {
        for bubble in bubbleCollection.bubbles {
            bubbleView[bubble] = OneBubble(bubble: bubble, bubbleBox: bubbleBox)
            
        }
        bubbleKeys = bubbleView.keys.map { $0 }
        self.bubbleBox = bubbleBox
    }
    
    mutating func bubbleViewUpdate(bubble bub: Bubble) {
        // 최대 10개 띄울 수 있게
        if (bubbleKeys.count >= 10) {
            bubbleKeys.remove(at: 0)
        }
        
        bubbleView[bub] = OneBubble(bubble: bub, bubbleBox: bubbleBox)
        bubbleKeys.append(bub)
    }
    
    var body: some View {
        
        ZStack {
                ForEach(self.bubbleKeys) { key in
                    self.bubbleView[key]
                }
        }
    
        .background(
            Image("background")
                .aspectRatio(contentMode: .fit))

    }
}

//struct SentBubbles_Previews: PreviewProvider {
//    static var previews: some View {
//        SentBubbles(bubbleCollection: BubbleManager())
//    }
//}
