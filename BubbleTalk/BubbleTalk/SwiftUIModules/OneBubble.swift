//
//  OneBubble.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct OneBubble: View {
    let screen = UIScreen.main.bounds

    @State private var wasDragged: Bool = false
    @State private var currentPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height )
    @State private var newPosition: CGPoint = .zero
    @State var beingTouched: Bool = false
    
    var bubText: String
    var bubProperty: BubProperty
    var lastAdded: Bool = true
    
    // 랜덤 위치 생성
    private var randomPosition = CGPoint(x: CGFloat((9.arc4random)) * 1/11 * (UIScreen.main.bounds.width) + 60, y: CGFloat((16.arc4random)) * 1/22 * (UIScreen.main.bounds.height) + 80)
    
    // 여러가지 버블 타입
    enum BubProperty: String {
        //        case largeBlue = "blueLargeBubble"
        //        case smallPink = "pinkSmallBubble"
         case greenBubble = "bubblegreen"
               case yellowBubble = "bubbleyellow"
               case blueBubble = "bubbleblue"
               case purpleBubble = "bubblepurple"
               case redBubble = "bubblered"
               case noBubble = "bubblenone"
        
        func backBubble() -> String {
            return "newWhiteBubble"
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
        
        switch type {
        case 0:
            bubProperty = .noBubble
            
        case 1:
            bubProperty = .purpleBubble
            
        case 2:
            bubProperty = .greenBubble
            
        case 3:
            bubProperty = .yellowBubble
        
        case 4:
            bubProperty = .redBubble
        default:
            bubProperty = .blueBubble
            
        }
        
    }
    
    var body: some View {
        
        GeometryReader { screen in
            
            if (!self.wasDragged) {
                Image(self.bubProperty.rawValue).resizable()
                    .frame(width: 140 , height:140)
                    .background(
                        Text(self.bubText)
                            .font(.body)
                            .foregroundColor(.black)
                )
                    .frame(alignment: .center)
                    .lineLimit(2)
                    .position(self.currentPosition)
                    
                    .onTapGesture {
                        withAnimation { self.wasDragged.toggle() }
                        self.beingTouched = !self.beingTouched
                        
                }                
                    
                .onAppear(perform: { self.currentPosition = self.randomPosition } )
                
            } else if (self.beingTouched) {
                Image(self.bubProperty.rawValue).resizable()
                    .frame(width: self.beingTouched ? 170 : 140 , height: self.beingTouched ? 170 : 140)
                    .background(
                        Text(self.bubText).font(.body)
                            .foregroundColor(.black)
                )
                    .frame(alignment: .center)
                    .lineLimit(2)
                    .position(self.currentPosition)
                    // beingTouched true일 때만 드래그 가능하도록 바꿔야
                    .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition.x = CGFloat(value.translation.width) + self.newPosition.x
                                self.currentPosition.y = CGFloat(value.translation.height) + self.newPosition.y
                        }
                        .onEnded { value in
                            self.currentPosition = CGPoint(x: CGFloat(value.translation.width) + self.newPosition.x, y: CGFloat(value.translation.height) + self.newPosition.y)
                            
                            self.newPosition = self.currentPosition
                            self.beingTouched = !self.beingTouched
                            }
                    )
                    
                    
                    .onTapGesture {
                        self.beingTouched = !self.beingTouched
                }
                    
                .onAppear(perform: { self.newPosition = self.currentPosition } )
                
            } else {
                Image(self.bubProperty.rawValue).resizable()
                    .frame(width: 140 , height: 140)
                    .background(
                        Text(self.bubText).font(.body)
                            .foregroundColor(.black)
                )
                    .frame(alignment: .center)
                    .lineLimit(2)
                    .position(self.currentPosition)
                    
                    .onTapGesture {
                        self.beingTouched = !self.beingTouched
                }
            }
        }
    }
}

struct BubbleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        OneBubble(bubText: "2", bubType: 2)
        
    }
}

extension OneBubble {
    mutating func unmarkLastAdded() {
        self.lastAdded = false
    }

}
