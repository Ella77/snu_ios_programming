//
//  OneBubble.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct OneBubble: View {
    
    var bubText: String
    var bubProperty: BubProperty
 
    // 버블 종류 2가지
    
    
    enum BubProperty: String {
        case largeBlue = "blueLargeBubble"
        case smallPink = "pinkSmallBubble"
        case hearts = "hearts"
        
        func backBubble() -> String {
            return "bubbleframeimg"
        }
        
        func lineLimit() -> Int {
            switch self {
            case .largeBlue: return 3
            case .smallPink: return 2
            case .hearts : return 4
            }
        }
        func bubWidth() -> CGFloat {
            switch self {
            case .largeBlue: return 100
            case .smallPink: return 80
            case .hearts : return 100
            }
        }
    }
    
    init(bubText txt: String, bubType type: Int) {
        bubText = txt
        switch type {
        case 1: bubProperty = .smallPink
        case 2: bubProperty = .largeBlue
        case 3: bubProperty = .hearts
//        case 4
//        case 5
        default: bubProperty = .largeBlue
        }
    }
    
    var body: some View {
        Group {
//            Text(bubText).font(.subheadline)
//                .lineLimit(bubProperty.lineLimit())
//                .frame(width: bubProperty.bubWidth())
            Image(bubProperty.backBubble())
                //.multilineTextAlignment(.center)
                .foregroundColor(.black)
                //.padding()
                .background(
                    Image(bubProperty.rawValue)
                        //.resizable()
                        //.frame(width:40, height:40)
                        .shadow(radius: 8)
                        //.animation(.spring())
        )
                
        }
    }
}

struct BubbleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        OneBubble(bubText: "", bubType: 3)
        
    }
}
