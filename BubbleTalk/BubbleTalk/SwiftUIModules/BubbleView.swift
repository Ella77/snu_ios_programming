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
    
    var body: some View {
        NavigationView {
            TabView {
                receivedBubblesView
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                        .imageScale(.large)
                        }
                sentBubblesView
                    .tabItem { 
                        Image(systemName: "paperplane.fill")
                        .imageScale(.medium)
                }
//                .transition(AnyTransition.scale
//                .combined(with: .opacity))
//                .animation(Animation.easeInOut(duration: 1))
                Text("보관함")
                    .tabItem {
                        NavigationLink(destination: Text("보관함")) {
                            Image(systemName: "archivebox")
                        }
                }
            }
            .navigationBarTitle(Text("BubbleTalk"), displayMode: .inline)
//            .navigationBarItems(trailing: NavigationLink(destination: Text("보관함")) {
//                Text("보관함")
//            })
        }
        .background(
            Image("background")
                .aspectRatio(contentMode: .fill)
        )
        
    }
}

extension BubbleView: UpdateBubbleViewState {
    mutating func addBubToRecievedBubbles(bubble: Bubble) {
        receivedBubblesView.bubbleViewUpdate(bubble: bubble)
    }
    mutating func addBubToSentBubbles(bubble: Bubble) {
        sentBubblesView.bubbleViewUpdate(bubble: bubble)
    }
}

//struct BubblesViewDrawing_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleView()
//    }
//}

protocol UpdateBubbleViewState {
    mutating func addBubToRecievedBubbles(bubble: Bubble)
    mutating func addBubToSentBubbles(bubble: Bubble)
}
