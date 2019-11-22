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
    private var recievedBubbleView: ReceivedBubbles
    private var sentBubblesView: SentBubbles
    init(recievedBubbleView: ReceivedBubbles, sentBubblesView: SentBubbles) {
        self.recievedBubbleView = recievedBubbleView
        self.sentBubblesView = sentBubblesView
    }
    
    var body: some View {
    
        VStack() {
            Toggle(isOn: $bubbleMode) {
                Text("Bubble Mode - Recieved or Sent ")
            }
            if (bubbleMode) {
                recievedBubbleView
            } else {
                sentBubblesView
            }
        
        }
    }
}

//struct BubblesViewDrawing_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleView()
//    }
//}

