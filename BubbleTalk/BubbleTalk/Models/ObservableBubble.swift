//
//  ObservableBubble.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/12/18.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation
import Combine
class ObservableBubble: ObservableObject  {
     
    //SwiftUI Biniding
    var bubble: Bubble {
        didSet { objectWillChange.send() }
    }
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init() {
        bubble = Bubble(text: "", type: 0, id: 0)
    }
    init(bubble: Bubble) {
        self.bubble = bubble
    }
}
