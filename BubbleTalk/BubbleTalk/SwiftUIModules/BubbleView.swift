//
//  BubbleView.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleView: View {
    var bubbleBox: BubbleBox
    
    @State private var bubbleMode: Bool = true
    @State private var selection: Int = 0
    @State private var background: Bool = false
    @State private var title = Text("")
    
    
    
    // 약간 억지로 viewcontroller의 textbox 안보이게 하기 위해 설정
    var uiBox: UIView?
    
    var receivedBubblesView: ReceivedBubbles
    private var sentBubblesView: SentBubbles
    
    private var bubbleStorage: BubbleBoxView 
    
    init(receivedBubbleView: ReceivedBubbles, sentBubblesView: SentBubbles, textBox: UIView, bubbleBox: BubbleBox) {
        self.receivedBubblesView = receivedBubbleView
        self.sentBubblesView = sentBubblesView
        self.uiBox = textBox
        
        self.bubbleBox = bubbleBox
        self.bubbleStorage = BubbleBoxView(bubbleBox: bubbleBox)
        
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                receivedBubblesView
                    .onAppear {
                        self.title = Text("받은 버블")
                }
                    .tabItem {
                        Image(selection == 0 ? "receive_blue-1" : "receive")
                           
                }.tag(0)
                sentBubblesView
                    .onAppear {
                            self.title = Text("보낸 버블")
                    }
                    .tabItem { 
                        Image(selection == 1 ? "mymessage_blue" : "mymessage")
                            
                }.tag(1)
                
                bubbleStorage
                    .onAppear {
                        self.uiBox?.isHidden = true
                        self.title = Text("보관함")
                }
                    .onDisappear { self.uiBox?.isHidden = false }
             
                    .tabItem {
                        Image(selection == 2 ? "inbox_blue" : "inbox")
                       
                }.tag(2)
                
            } 
                //요거 다시 조정
                .navigationBarTitle(self.title, displayMode: .inline
            )
                
                .navigationBarItems(trailing: selection == 2 ? Text("") : Text("배경") )
            
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


