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
        Form() {
            Toggle(isOn: $bubbleMode) {
                Text("Toggle On : Recieved // off: Sent ")
            }
            //.zIndex(1)
            
            if (bubbleMode) {
                recievedBubbleView
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

