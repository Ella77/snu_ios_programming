//
//  ViewController.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/13.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import UIKit
import SwiftUI

var Talk = Model()

class ViewController: UIViewController {
    private var bubCollection = BubbleCollection()
    lazy private var bubbles = BubbleView(bubbleCollection: bubCollection)
    lazy private var uiHost = UIHostingController(rootView: bubbles)

    
    // 샘플 데이터
    var bubbleSample = [ "크리스마스라니!", "나 오늘 저녁 뭐 먹지?", "난 고양이보다 강아지가 좋아", "헐 진짜?", "이제 너무 추운 것 같아", "가나다라바사", "인터페이스 프로그래밍 5조", "징글벨 징글벨 징글 올 더 웨이~" ]
    
    override func viewWillAppear(_ animated: Bool) {
        uiHost.rootView = bubbles
        //print(uiHost.rootView.bubbleKeys)
    }
    override func viewDidAppear(_ animated: Bool) {
        var i = 0
        // 2초 마다 하나씩 뜨도록 타이머 설정
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            if (i < self.bubbleSample.count) {
                var text = self.bubbleSample[i]
                var size: Int  { return text.count < 10 ? 1 : 2}
                let newBub = Bubble(text: text, size: size, id: i)
                self.bubCollection.bubbleAppend(bubble: newBub)
                self.bubbles.bubbleViewUpdate(bubble: newBub)
                self.viewWillAppear(true)
                i += 1
                
                //make New Bubble (instead of bubbleCollection)
                let bubb : Bubble = Talk.makeNewBubble(txt: text)
                print(bubb.text,"\t",bubb.size)
                
                
            } else {
                timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBSegueAction func addSwiftUI(_ coder: NSCoder) -> UIViewController? {
        uiHost = UIHostingController(coder: coder, rootView: bubbles)!
        return uiHost
    }
    
    // 테스트용으로 버튼 누르면 새 버블 뜨게 할까? 고민했던 함수
    //    @IBAction func newBubble(_ sender: UIButton) {
    //       // bubble.newbubbleButton()
    //    }
    
    // SwiftUI와 Hosting 방식으로 연결
    
}


