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

struct SentBubbles_Previews: PreviewProvider {
    static var previews: some View {
        SentBubbles(bubbleCollection: BubbleManager())
    }
}
