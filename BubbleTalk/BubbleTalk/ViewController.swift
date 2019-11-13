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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // SwiftUI와 Hosting 방식으로 연결
    @IBSegueAction func addSwiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: BubbleSwiftUIView())
    }
}

