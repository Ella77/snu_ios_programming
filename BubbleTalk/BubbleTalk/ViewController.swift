//
//  ViewController.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/13.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private var bubCollection = BubbleCollection()
    lazy private var bubbles = BubbleView(bubbleCollection: bubCollection)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 테스트용으로 버튼 누르면 새 버블 뜨게 할까? 고민했던 함수
//    @IBAction func newBubble(_ sender: UIButton) {
//       // bubble.newbubbleButton()
//    }
    
    // SwiftUI와 Hosting 방식으로 연결
    @IBSegueAction func addSwiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: bubbles)
    }
}

