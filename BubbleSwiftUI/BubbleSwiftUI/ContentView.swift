//
//  ContentView.swift
//  BubbleSwiftUI
//
//  Created by JSKeum on 2019/11/13.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var bubble: TextData
    
    var body: some View {
    HStack {
        Text(bubble.text)
           }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bubble: TextData(text: "123", size: 1))
    }
}
}
