//
//  BubbleStorage.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/12/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleBoxView: View {
//    var bubbleBox: BubbleBox
    
    var body: some View {
        List {
        Text("보관함 버블1")
            Text("보관함 버블2")
            Text("보관함 버블3")
            Text("보관함 버블4")
        }
        
    }
}

struct BubbleStorage_Previews: PreviewProvider {
    static var previews: some View {
        BubbleBoxView()
    }
}
