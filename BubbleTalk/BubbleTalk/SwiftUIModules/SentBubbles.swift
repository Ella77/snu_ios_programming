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
    
    init(bubbleCollection: BubbleManager) {
        for bubble in bubbleCollection.bubbles {
            bubbleView[bubble] = OneBubble(bubText: bubble.text, bubType: bubble.type)
        }
        bubbleKeys = bubbleView.keys.map { $0 }
    }
    
    mutating func bubbleViewUpdate(bubble bub: Bubble) {
        // 최대 4개 띄울 수 있게 해놨어요
        if (bubbleKeys.count >= 4) {
            bubbleKeys.remove(at: 0)
        }
        
        bubbleView[bub] = OneBubble(bubText: bub.text, bubType: bub.type)
        bubbleKeys.append(bub)
    }
    
    var body: some View {
        
        VStack {
            ForEach(bubbleKeys) { key in
                self.bubbleView[key]
                    .animation(Animation.default)
            }
        }
            
        .background(
            Image("background")
                .aspectRatio(contentMode: .fit))
        
        
    }
}

struct SentBubbles_Previews: PreviewProvider {
    static var previews: some View {
        SentBubbles(bubbleCollection: BubbleManager())
    }
}
