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
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
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
                
<<<<<<< HEAD
                Image(self.bubProperty.backBubble())
                    //.multilineTextAlignment(.center)
                    .resizable()
                    
                    .frame(width:170, height:170)
                    .foregroundColor(.black)
                    //.padding()
                    .background(
                        Text(self.bubText).font(.system(size: 80))
                            .frame(alignment: .center)
                            .lineLimit(1)
                        //                            .frame(width: bubProperty.bubWidth(), alignment: .center)
                        
                )
                    .position(CGPoint(x: CGFloat(CGFloat.random(in: 40...(screen.size.width - 40))), y: CGFloat(CGFloat.random(in: 30...(screen.size.height - 30)))))
                
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
                
            } else if (self.isNotInBubble) {
                Image(self.bubProperty.rawValue)
                    .resizable()
                    
                    .frame(width:170, height:170)
                    .position(CGPoint(x: CGFloat(CGFloat.random(in: 40...(screen.size.width - 40))), y: CGFloat(CGFloat.random(in: 30...(screen.size.height - 30)))))
                
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
                
            } else {
                Image(self.bubProperty.backBubble())
                    .resizable()
                    .frame(width:170, height:170)
                    .foregroundColor(.black)
                    .background(
                        Image(self.bubProperty.rawValue)
                            .resizable()
                            .frame(width:130, height:130)
                            .shadow(radius: 8)
                        //.animation(.spring())
                )
                    .position(CGPoint(x: CGFloat(CGFloat.random(in: 40...(screen.size.width - 40))), y: CGFloat(CGFloat.random(in: 30...(screen.size.height - 30)))))
                    
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
                
                
=======
                if (!self.wasDragged) {
                    Text(self.bubText).font(.system(size: 60))
                        .background(
                            Image(self.bubProperty.backBubble())
                                .resizable()
                                .frame(width:170, height:170)
                                .foregroundColor(.black)
                    )
                        .frame(alignment: .center)
                        .lineLimit(1)
                        .position(CGPoint(x: CGFloat(CGFloat.random(in: 40...(screen.size.width - 40))), y: CGFloat(CGFloat.random(in: 60...(screen.size.height - 30)))))
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
                        .position(CGPoint(x: CGFloat(CGFloat.random(in: 40...(screen.size.width - 40))), y: CGFloat(CGFloat.random(in: 60...(screen.size.height - 30)))))
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
                        .position(CGPoint(x: CGFloat(CGFloat.random(in: 40...(screen.size.width - 40))), y: CGFloat(CGFloat.random(in: 60...(screen.size.height - 30)))))
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
>>>>>>> 2495e87cc9aa7455c4d9d4818cfa0652aabd6e1f
            }
        }
    }
}

struct BubbleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        OneBubble(bubText: "2", bubType: 2)
        
    }
}
