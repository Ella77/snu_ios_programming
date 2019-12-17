//
//  BubbleStorage.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/12/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI


struct BubbleBoxView: View {
    @ObservedObject var bubbleBox: BubbleBox 
    
    private func deleteBubbleFromStorage(at : IndexSet) {
        bubbleBox.bubbles.remove(atOffsets: at)
        bubbleBox.exportToJson()
        print("지금 버블박스 버블뷰 : \(self.bubbleBox.bubbles)")
        print("dfs \(at)")
    }
    var body: some View {
        List {
            ForEach(bubbleBox.bubbles) { bubble in
               Text(bubble.text)
                
                
            }
            .onDelete(perform: deleteBubbleFromStorage)
            .onAppear { print("버블박스 버블뷰 : \(self.bubbleBox.bubbles)") }
        }
        
    }
}

//struct BubbleStorage_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleBoxView()
//    }
//}
