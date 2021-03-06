//
//  BubbleDrawing.swift
//  BubbleSwiftUI
//
//  Created by JSKeum on 2019/11/16.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleDrawing: View {
    
    var bubText: String
    var bubProperty: BubProperty
    
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    // 버블 종류 2가지
    enum BubProperty: String {
        case largeBlue = "blueLargeBubble"
        case smallPink = "pinkSmallBubble"
        
        func lineLimit() -> Int {
            switch self {
            case .largeBlue: return 3
            case .smallPink: return 2
            }
        }
        func bubWidth() -> CGFloat {
            switch self {
            case .largeBlue: return 100
            case .smallPink: return 80
            }
        }
    }
    
    init(bubText txt: String, bubType type: Int) {
        bubText = txt
        switch type {
        case 1: bubProperty = .smallPink
        case 2: bubProperty = .largeBlue
        default: bubProperty = .largeBlue
        }
    }
    
    var body: some View {
        Group {
            Text(bubText).font(.subheadline)
                .lineLimit(bubProperty.lineLimit())
                .frame(width: bubProperty.bubWidth())
                //.multilineTextAlignment(.center)
                .foregroundColor(.black)
                //.padding()
                .background(
                    Image(bubProperty.rawValue)
                        //.resizable()
                        .shadow(radius: 8)
                        .animation(.spring())
                        
                        
                    )
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
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
}

struct BubbleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        BubbleDrawing(bubText: "1231244444444444443333312332131313213131313", bubType: 1)
    }
}
