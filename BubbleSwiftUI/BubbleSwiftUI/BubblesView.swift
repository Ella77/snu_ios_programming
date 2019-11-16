//
//  BubblesViewDrawing.swift
//  BubbleSwiftUI
//
//  Created by JSKeum on 2019/11/16.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubblesView: View {
    
    //ViewBuilder 에러 해결 후 optional로 바꿀 것
    var bubbleView = [Bubble: BubbleDrawing]()
    var BubbleKeys: [Bubble] {
        return bubbleView.keys.map { $0 }
    }
    
    init(bubbleCollection: BubbleCollection) {
        //bubbleCollection = bubCol
        for bubble in bubbleCollection.bubbles {
            bubbleView[bubble] = BubbleDrawing(bubText: bubble.text, bubType: bubble.size)
        }
    }
    
    mutating func bubbleViewUpdate(bubble bub: Bubble) {
        bubbleView[bub] = BubbleDrawing(bubText: bub.text, bubType: bub.size)
    }

    var body: some View {
        VStack() {
            Spacer()
            // Closure containing control flow statement cannot be used with function builder 'ViewBuilder'
            // 이 에러 때문에 논리식을 못쓰네요.. 해결책을 찾아야
            HStack() {
                Spacer()
                bubbleView[BubbleKeys[0]]
                Spacer()
                Spacer()
                bubbleView[BubbleKeys[1]]
                Spacer()
            }
            Spacer()
            HStack() {
                Spacer()
                bubbleView[BubbleKeys[2]]
                Spacer()
                Spacer()
                bubbleView[BubbleKeys[3]]
                Spacer()
            }
            Spacer()
            HStack() {
                Spacer()
                bubbleView[BubbleKeys[4]]
                Spacer()
                Spacer()
                bubbleView[BubbleKeys[5]]
                Spacer()
            }
            Spacer()
            HStack() {
                Spacer()
                bubbleView[BubbleKeys[6]]
                Spacer()
                Spacer()
                bubbleView[BubbleKeys[7]]
                Spacer()
            }
            Spacer()
        }
    }
}

struct BubblesViewDrawing_Previews: PreviewProvider {
    static var previews: some View {
        BubblesView(bubbleCollection: BubbleCollection())
    }
}
