//
//  ViewController.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/11/13.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    
    private var receivedTalk = BubbleManager()
    private var sentTalk = BubbleManager()
    
    lazy private var receivedBubbleView: ReceivedBubbles = ReceivedBubbles(bubbleCollection: receivedTalk)
    lazy private var sentBubbledView: SentBubbles = SentBubbles(bubbleCollection: sentTalk)
    
    lazy private var bubbleView: BubbleView = BubbleView(receivedBubbleView: receivedBubbleView, sentBubblesView: sentBubbledView)
    lazy private var uiHost = UIHostingController(rootView: bubbleView)
    
    // 샘플 데이터 -> "1" 은 버블 있는 이미지 / "2" 는 버블 없는 이미지 / 다른 String은 그냥 String(이모지 포함)
    var bubbleSample = [ "🎃", "1", "2", "안녕", "아이폰", "👻", "👀", "ABC" ]
    
    override func viewWillAppear(_ animated: Bool) {
        //registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //unregisterForKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var i = 0
        // 2초 마다 하나씩 뜨도록 타이머 설정
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            if (i < self.bubbleSample.count) {
                let text = self.bubbleSample[i]
                let newBub : Bubble = self.receivedTalk.makeNewBubble(txt: text)
                self.uiHost.rootView.addBubToRecievedBubbles(bubble: newBub)
//                self.uiHost.rootView = self.bubbleView
                i += 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        
        textField.returnKeyType = .done
        
        //textfield올리기
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
    }
    
    // SwiftUI와 Hosting 방식으로 연결
    @IBSegueAction func addSwiftUI(_ coder: NSCoder) -> UIViewController? {
        uiHost = UIHostingController(coder: coder, rootView: bubbleView)!
//                print("\n \(uiHost.rootView) \n")
        return uiHost
    }
    
}

// extension about textfield and keyboard
extension ViewController {
    //키보드 delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 10
    } //글자수 10자로 제한
    
    func textFieldShouldReturn(_: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // 텍스트 보내면 sentBubbles에 뜨도록 설정
        if let text = textField.text {
            let newBub = sentTalk.makeNewBubble(txt: text)
            bubbleView.addBubToSentBubbles(bubble: newBub)
            uiHost.rootView = bubbleView
            
        }
        return false //return 누르면 키보드 사라짐
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    } //화면터치 시 키보드 내려옴
    
    @objc func keyboardWillShow(_ notification: Notification){
        guard let userInfo = notification.userInfo as? [String:Any] else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.cgRectValue.height + 60)
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        self.view.transform = .identity
    }
}


