//
//  SentBubbles.swift
//  BubbleSwiftUI
//
//  Created by JSKeum on 2019/11/22.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct SentBubbles: View {
    private var bubbleView = [Bubble: BubbleDrawing]()
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
            bubbleView[bubble] = BubbleDrawing(bubText: bubble.text, bubType: bubble.size)
        }
    }
    
    mutating func bubbleViewUpdate(bubble bub: Bubble) {
        bubbleView[bub] = BubbleDrawing(bubText: bub.text, bubType: bub.size)
    }
    
    var body: some View {
        Group {
            HStack {
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

struct SentBubbles_Previews: PreviewProvider {
    static var previews: some View {
        SentBubbles(bubbleCollection: BubbleCollection())
    }
}
