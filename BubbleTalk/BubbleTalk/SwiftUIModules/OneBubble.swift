//
//  OneBubble.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct OneBubble: View {
    @State private var wasDragged: Bool = false
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State var beingTouched: Bool = false
    
    var bubText: String
    var bubProperty: BubProperty
//    var isText: Bool
//    var isNotInBubble: Bool
   
    // 랜덤 위치 생성
    private let randomXPosition: CGFloat = CGFloat((8.arc4random)) * 1/8
    private let randomYPosition: CGFloat = CGFloat((16.arc4random)) * 1/16

    // 여러가지 버블 타입
    enum BubProperty: String {
        //        case largeBlue = "blueLargeBubble"
        //        case smallPink = "pinkSmallBubble"
        case hearts = "piggy"
        case heartsSteaker = "hearts_sticker"
        case whiteBubble = "newWhiteBubble"
        case blueBubble = "bubbleframeimg"
        
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
            bubProperty = .whiteBubble
         
        case 1:
            bubProperty = .blueBubble
          
        case 2:
            bubProperty = .whiteBubble
         
        default:
            bubProperty = .whiteBubble
        }
        
    }
    
    var body: some View {
        
        GeometryReader { screen in
            
                if (!self.wasDragged) {
                    Image(self.bubProperty.rawValue).resizable()
                        .frame(width: 170 , height:170)
                                            .background(
                                               Text(self.bubText).font(.system(size: 60))
                                                    .foregroundColor(.black)
                                        )
                        .frame(alignment: .center)
                        .lineLimit(1)
                        .position(CGPoint(x: self.currentPosition.width, y: self.currentPosition.height))
                        
                        .onTapGesture {
                            withAnimation { self.wasDragged.toggle() }
                            self.beingTouched = !self.beingTouched
                            
                            
                            
                    }
                    .onAppear(perform: {  self.currentPosition = CGSize(width: self.randomXPosition * screen.size.width, height: self.randomYPosition * screen.size.height) })
                    
                } else if (self.beingTouched) {
                     Image(self.bubProperty.rawValue).resizable()
                    .frame(width: self.beingTouched ? 200 : 170 , height: self.beingTouched ? 200 : 170) 
                                                               .background(
                                                                  Text(self.bubText).font(.system(size: 60))
                                                                       .foregroundColor(.black)
                                                           )
                                           .frame(alignment: .center)
                                           .lineLimit(1)
                        .position(CGPoint(x: self.currentPosition.width, y: self.currentPosition.height))
                        // beingTouched true일 때만 드래그 가능하도록 바꿔야
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition.width = value.translation.width + self.newPosition.width
                                self.currentPosition.height = value.translation.height + self.newPosition.height
                        }
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
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
                        .frame(width: 170 , height: 170)
                                                               .background(
                                                                  Text(self.bubText).font(.system(size: 60))
                                                                       .foregroundColor(.black)
                                                           )
                                           .frame(alignment: .center)
                                           .lineLimit(1)
                        .position(CGPoint(x: self.currentPosition.width, y: self.currentPosition.height))
                  
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
