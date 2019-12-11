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
    
    var bubText: String
    var bubProperty: BubProperty
    var isText: Bool
    var isNotInBubble: Bool
   
    // 랜덤 위치 생성
    private let randomXPosition: CGFloat = CGFloat((8.arc4random)) * 1/8
    private let randomYPosition: CGFloat = CGFloat((16.arc4random)) * 1/16

    // 여러가지 버블 타입
    enum BubProperty: String {
        //        case largeBlue = "blueLargeBubble"
        //        case smallPink = "pinkSmallBubble"
        case hearts = "piggy"
        case heartsSteaker = "hearts_sticker"
        case text
        
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
        GeometryReader { screen in
            if (self.isText) {
                
                if (!self.wasDragged) {
//                    Text(self.bubText).font(.system(size: 60))
//                        .background(
//                            Image(self.bubProperty.backBubble())
//                                .resizable()
//                                .frame(width:170, height:170)
//                                .foregroundColor(.black)
//                    )
                    /// 자굼 슈저
                    Image("bubbleframeimg").resizable()
                    .frame(width:170, height:170)
                                            .background(
                                               Text(self.bubText).font(.system(size: 60))
                                                    
                                                    .foregroundColor(.black)
                                        )
                        
                        .frame(alignment: .center)
                        .lineLimit(1)
                        .position(CGPoint(x: self.randomXPosition * screen.size.width, y: self.randomYPosition * screen.size.height))
                        .onTapGesture {
                            withAnimation { self.wasDragged.toggle() }
                            
                    }
                } else {
                    Text(self.bubText).font(.system(size: 60))
                        .background(
                            Image(self.bubProperty.backBubble())
                                .resizable()
                                .frame(width:170, height:170)
                                .foregroundColor(.black)
                    )
                        .frame(alignment: .center)
                        .lineLimit(1)
                        .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                        }
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                            self.newPosition = self.currentPosition
                            }
                    )
                }
            } else if (self.isNotInBubble) {
                if (!self.wasDragged) {
                    Image(self.bubProperty.rawValue)
                        
                        .resizable()
                        .frame(width:170, height:170)
                        .position(CGPoint(x: self.randomXPosition * screen.size.width, y: self.randomYPosition * screen.size.height))
                        .onTapGesture {
                            withAnimation { self.wasDragged.toggle() }
                            
                    }
                } else {
                    Image(self.bubProperty.rawValue)
                        .resizable()
                        .frame(width:170, height:170)
                        .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                        }
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                            self.newPosition = self.currentPosition
                            }
                    )
                }
                
            } else {
                if (!self.wasDragged) {
                    Image(self.bubProperty.rawValue)
                        .resizable()
                        .frame(width:130, height:130)
                        .shadow(radius: 8)
                        .background(
                            
                            Image(self.bubProperty.backBubble())
                                .resizable()
                                .frame(width:170, height:170)
                                .foregroundColor(.black)
                    )
                        .position(CGPoint(x: self.randomXPosition * screen.size.width, y: self.randomYPosition * screen.size.height))
                        .onTapGesture {
                            withAnimation { self.wasDragged.toggle() }
                            
                    }
                } else {
                    Image(self.bubProperty.rawValue)
                        .resizable()
                        .frame(width:130, height:130)
                        .shadow(radius: 8)
                        .background(
                            Image(self.bubProperty.backBubble())
                                .resizable()
                                .frame(width:170, height:170)
                                .foregroundColor(.black)
                    )
                        .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                        }
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                            self.newPosition = self.currentPosition
                            }
                    )
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
