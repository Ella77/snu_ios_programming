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
    
  var keyboardShown:Bool = false // 키보드 상태 확인
  var originY:CGFloat? // 오브젝트의 기본 위치
    private var talk = BubbleManager()
    lazy private var bubbles = BubbleView(bubbleCollection: talk)
    lazy private var uiHost = UIHostingController(rootView: bubbles)
    
  
    // 샘플 데이터
    var bubbleSample = [ "크리스마스라니!", "나 오늘 저녁 뭐 먹지?", "난 고양이보다 강아지가 좋아", "헐 진짜?", "이제 너무 추운 것 같아", "가나다라바사", "인터페이스 프로그래밍 5조", "징글벨 징글벨 징글 올 더 웨이~" ]
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        uiHost.rootView = bubbles
        //print(uiHost.rootView.bubbleKeys)
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
                var text = self.bubbleSample[i]
                var size: Int  { return text.count < 10 ? 1 : 2 }
                let newBub : Bubble = self.talk.makeNewBubble(txt: text)
                self.bubbles.bubbleViewUpdate(bubble: newBub)
                self.viewWillAppear(true)
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
  
              
    //키보드 delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 10
    } //글자수 10자로 제한
    

    func textFieldShouldReturn(_: UITextField) -> Bool {
        textField.resignFirstResponder()
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
      

    
    // SwiftUI와 Hosting 방식으로 연결
    @IBSegueAction func addSwiftUI(_ coder: NSCoder) -> UIViewController? {
        uiHost = UIHostingController(coder: coder, rootView: bubbles)!
        return uiHost
    }
    
    
    
}


