//
//  Timer.swift
//  BubbleSwiftUI
//
//  Created by JSKeum on 2019/11/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import Foundation

struct Timer {
    static var startingTime: TimeInterval = NSDate().timeIntervalSince1970
    static var timeInterval: TimeInterval = 1000
    
    static func startTimer(interval: Double) {
        startingTime = NSDate().timeIntervalSince1970
        timeInterval = interval
    }
    static func startTimer() {
        startingTime = NSDate().timeIntervalSince1970
        timeInterval = 1000
    }
    static func isTimerFinished() -> Bool {
        let current = NSDate().timeIntervalSince1970
        return current - startingTime >= timeInterval ? true : false
    }
}


