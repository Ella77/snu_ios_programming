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
    @State private var background: Bool = false
    
    private var title: titleView = titleView(title: "")
    
    
    // 약간 억지로 viewcontroller의 textbox 안보이게 하기 위해 설정
    var uiTextBox: UIView?
    
    
    var receivedBubblesView: ReceivedBubbles
    private var sentBubblesView: SentBubbles
    private var bubbleStorage: BubbleBoxView = BubbleBoxView()
    
    init(receivedBubbleView: ReceivedBubbles, sentBubblesView: SentBubbles, textBox: UIView) {
        self.receivedBubblesView = receivedBubbleView
        self.sentBubblesView = sentBubblesView
        self.uiTextBox = textBox
        
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
                
                bubbleStorage
                    .onAppear {
                        self.uiTextBox?.isHidden = true
//                        self.titleView.title = "보관함"
//                        self.navigationBarTitle(Text("보관함"))
                }
                    .onDisappear { self.uiTextBox?.isHidden = false }
                    
                    
                    .tabItem {
                        Image(systemName: "archivebox")
                       
                }.tag(2)
                
            } 
                //요거 다시 조정
                .navigationBarTitle(Text("탭 타이틀") , displayMode: .inline)
                
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

struct titleView: View {
    var title: String
    
    var body: some View {
        Text(title)
    }
}
