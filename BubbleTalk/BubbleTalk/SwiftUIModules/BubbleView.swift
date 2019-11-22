//
//  BubbleView.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleView: View {
    @State private var bubbleMode: Bool = true
    
    var receivedBubblesView: ReceivedBubbles
    private var sentBubblesView: SentBubbles

    init(receivedBubbleView: ReceivedBubbles, sentBubblesView: SentBubbles) {
        self.receivedBubblesView = receivedBubbleView
        self.sentBubblesView = sentBubblesView
    }
    
    mutating func addBubToRecievedBubbles(bubble: Bubble) {
        receivedBubblesView.bubbleViewUpdate(bubble: bubble)
    }
    
    mutating func addBubToSentBubbles(bubble: Bubble) {
        sentBubblesView.bubbleViewUpdate(bubble: bubble)
    }
    
    var body: some View {
        Form() {
            Toggle(isOn: $bubbleMode) {
                Text("Toggle On : Recieved // off: Sent ")
            }
            //.zIndex(1)
            if (bubbleMode) {
                receivedBubblesView
            } else {
                sentBubblesView
            }
            //.zIndex(2)
        }
    }
}

//struct BubblesViewDrawing_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleView()
//    }
//}

