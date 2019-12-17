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
    @State private var presentModally: Bool = false
    @State private var background: Bool = false
    
    
    // 약간 억지로 viewcontroller의 textbox 안보이게 하기 위해 설정
    var uiTextBox: UIView?
    
    var receivedBubblesView: ReceivedBubbles
    private var sentBubblesView: SentBubbles
    
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
                
                Text("")
                    .onAppear {
                        self.uiTextBox?.isHidden = true
//                        self.navigationBarTitle(Text("보관함"))
                }
                    .onDisappear { self.uiTextBox?.isHidden = false }
       
                    .tabItem {
                        Image(systemName: "archivebox")
                        NavigationLink(destination: Text("보관함")) {
                            Image(systemName: "archivebox")
                                                        .navigationBarTitle(Text("보관함") , displayMode: .inline)
                            
                        }
                }.tag(2)
                
            }.sheet(isPresented: $presentModally, onDismiss: { self.selection = 0 } ) {
                                    Text("보관함")
                            }
                
                //요거 다시 조정
                .navigationBarTitle(selection == 0 ? Text("받은 버블") : Text("보낸 버블") , displayMode: .inline)
                
                .navigationBarItems(trailing: Text("배경") )
            
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
