//
//  BubbleView.swift
//  BubbleSwiftUI
//
//  Created by JSKeum on 2019/11/22.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleView: View {
    @State private var changeBubMode: Bool = true
    var body: some View {
        VStack() {
            Toggle(isOn: $changeBubMode) {
                Text("123")
            }
            if changeBubMode {
            ReceivedBubbles(bubbleCollection: BubbleCollection())
            } else {
            SentBubbles(bubbleCollection: BubbleCollection())
            }
        }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView()
    }
}
