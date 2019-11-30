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
    var isText: Bool
    var isNotInBubble: Bool
    
    // 여러가지 버블 타입
    enum BubProperty: String {
        //        case largeBlue = "blueLargeBubble"
        //        case smallPink = "pinkSmallBubble"
        case hearts = "piggy"
        case heartsSteaker = "hearts_sticker"
        case text
        
        func backBubble() -> String {
            return "bubbleframeimg"
        }
        
        //        func lineLimit() -> Int {
        //            switch self {
        //            case .largeBlue: return 3
        //            case .smallPink: return 2
        //            case .hearts : return 4
        //            }
        //        }
        //        func bubWidth() -> CGFloat {
        //            switch self {
        //            case .largeBlue: return 100
        //            case .smallPink: return 80
        //            case .hearts : return 100
        //            }
        //        }
    }
    
    init(bubText txt: String, bubType type: Int) {
        bubText = txt
        isNotInBubble = false
        switch type {
        case 0:
            bubProperty = .text
            self.isText = true
        case 1:
            bubProperty = .hearts
            self.isText = false
        case 2:
            bubProperty = .heartsSteaker
            self.isText = false
            isNotInBubble = true
            
        default:
            bubProperty = .text
            self.isText = true
        }
    }
    
    var body: some View {
        Group {
            if (isText) {
                Image(bubProperty.backBubble())
                    //.multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    //.padding()
                    .background(
                        Text(bubText).font(.system(size: 80))
                            .frame(alignment: .center)
                            .lineLimit(1)
                        //                            .frame(width: bubProperty.bubWidth(), alignment: .center)
                )
            } else if (isNotInBubble) {
                Image(bubProperty.rawValue)

            } else {
                Image(bubProperty.backBubble())
                    .resizable()
                    
                    .frame(width:170, height:170)
                    .foregroundColor(.black)
                    
                    .background(
                        Image(bubProperty.rawValue)
                            .resizable()
                            .frame(width:130, height:130)
                            .shadow(radius: 8)
                        //.animation(.spring())
                )
            }
        }
    }
}

struct BubbleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        OneBubble(bubText: "2", bubType: 2)
        
    }
}
