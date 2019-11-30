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
    
   /*var body: some View {
    HStack {
        Text(bubble.text)
           }*/
        
        @State private var currentPosition: CGSize = .zero
        @State private var newPosition: CGSize = .zero
        
        var body: some View {
            // 2.
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.red)
                .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                // 3.
                .gesture(DragGesture()
                    .onChanged { value in
                        self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                }   // 4.
                    .onEnded { value in
                        self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                        print(self.newPosition.width)
                        self.newPosition = self.currentPosition
                    }
            )
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bubble: TextData(text: "123", size: 1))
    }
}


