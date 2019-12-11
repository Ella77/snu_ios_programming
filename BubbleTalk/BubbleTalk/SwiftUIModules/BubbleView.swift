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
    @State private var selection: Int = 0
    
    var receivedBubblesView: ReceivedBubbles
    private var sentBubblesView: SentBubbles
    
    init(receivedBubbleView: ReceivedBubbles, sentBubblesView: SentBubbles) {
        self.receivedBubblesView = receivedBubbleView
        self.sentBubblesView = sentBubblesView
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                receivedBubblesView
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .imageScale(.large)
                }.tag(0)
                sentBubblesView
                    .tabItem { 
                        Image(systemName: "paperplane.fill")
                            .imageScale(.medium)
                }.tag(1)
                //                .transition(AnyTransition.scale
                //                .combined(with: .opacity))
                //                .animation(Animation.easeInOut(duration: 1))
                
                Text("보관함")
                    .tabItem {
                        NavigationLink(destination: Text("보관함")) {
                            Image(systemName: "archivebox")
                            //                            .navigationBarTitle(Text("보관함") , displayMode: .inline)
                            
                        }.tag(2)
                }
                
            }
                // hidden은 다시
                //                .navigationBarHidden(selection == 1 ? true : false)
                .navigationBarTitle(selection == 0 ? Text("받은 버블") : Text("보낸 버블") , displayMode: .inline)
                
                .navigationBarItems(trailing: Text("배경"))
            
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
