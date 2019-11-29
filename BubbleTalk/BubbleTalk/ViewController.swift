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
    // IBOutlet for Bluetooth test
//    @IBOutlet weak var messageLabel: UILabel!
    
    // properties for Bluetooth
    private var peripheral: BluetoothPeripheral!
    private var centralManager: BluetoothCentral?
    private var lastReceivedRssi: [Int64: TimeInterval] = [:]
    //
    
    //
    @IBOutlet weak var textField: UITextField!
    
    
    
    
    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    //
    
    //
    private var receivedTalk = BubbleManager()
    private var sentTalk = BubbleManager()
    
    private var receivedBubbleView: ReceivedBubbles {
        return ReceivedBubbles(bubbleCollection: receivedTalk)
    }
    private var sentBubbledView: SentBubbles {
        return SentBubbles(bubbleCollection: sentTalk)
    }
    
    private var bubbleView: BubbleView  {
        return BubbleView(receivedBubbleView: receivedBubbleView, sentBubblesView: sentBubbledView)
    }
    
    lazy private var uiHost = UIHostingController(rootView: bubbleView)
    //
    
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
        // Bluetooth setup
        setupCentral()
        setupPeripheral()
        //
        
        self.textField.delegate = self
        textField.returnKeyType = .send
        
        self.hideKeyboard() //화면터치시 키보드 내려옴
        
        //textfield올리기
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                                      selector: #selector(textDidChange(_:)),
                                                      name: UITextField.textDidChangeNotification,
                                                      object: textField)
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
   /* func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 10
    } //글자수 10자로 제한 */
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // 텍스트 작성하면 text로 값 전달
        // 텍스트 보내면 sentBubbles에 뜨도록 설정
        if let text = textField.text {
            let newBub = sentTalk.makeNewBubble(txt: text)
            uiHost.rootView.addBubToSentBubbles(bubble: newBub)
            
        }
        return false //return 누르면 키보드 사라짐
    }
    
     
    
    @objc func keyboardWillShow(_ notification: Notification){
        guard let userInfo = notification.userInfo as? [String:Any] else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.cgRectValue.height + 60)
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        self.view.transform = .identity
    }
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count >= 10 {
                    let index = text.index(text.startIndex, offsetBy: 10)
                    let newString = String(text[..<index])
                    textField.text = newString
                }
            }
        }
    }
    //optional func textFieldShouldClear(_ textField: UITextField) -> Bool
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}

// extension for Bluetooth
extension ViewController {

    // 메시지 받는거 테스트용
//    @IBAction func respondToSendMessage(_ sender: UIButton) {
//        postIfPossible()
//    }
    
    private func setupPeripheral() {
        peripheral = BluetoothPeripheral.init(uuid: "eab4e877-9e9d-4325-8996-bcea7fcc9b34")
        peripheral.didUpdateStateHandler = { manager, state in
            switch state {
            case .poweredOn:
                print("Bluetooth Peripheral Power On")
            case .unavailable:
                self.stop()
                print("Bluetooth Peripheral Unavailable")
                break
            }
        }
    }
    
    private func setupCentral() {
        centralManager = BluetoothCentral(uuid: "eab4e877-9e9d-4325-8996-bcea7fcc9b34")
        
        centralManager?.didUpdateStateHandler = { manager, state in
            switch state {
            case .poweredOn:
                manager.scan(allowDuplicate: false)
                print("Bluetooth Central Power On")
            case .unavailable:
                manager.stop()
                print("Bluetooth Central Unavailable")
            }
        }
        
        centralManager?.didReceivedDataHandler = { [weak self] (message, rssi, txPower) in
            guard let self = self, let message = message else { return }
            // message가 블루투스로 받은 텍스트
            
            // 테스트용
            //self.messageLabel.text = message
            
           //******* 여기서 받은 메시지 처리 작업 ********
            // BubbleManager로 버블 만들기
            
            //line 224 "Test" 받는지 확인해야
            //let textbub = self.messageLabel.text
            //let tmpBub : Bubble = self.receivedTalk.makeNewBubble(txt: textbub)
            //self.uiHost.rootView.addBubToRecievedBubbles(bubble: tmpBub)
        }
        
        if BluetoothPeripheral.hasPermission { centralManager?.initialize() }
    }
    
    private func postIfPossible() {
        if peripheral.currentState == .poweredOn {
            post()
        } else {
            stop()
        }
    }
    
    private func post() {
        //******* 여기서 보낸 메시지 처리 작업 ********
        // line 118에 있는 textFieldShouldReturn()이 View에서 텍스트 입력하면 return하는 곳입니다
        // "Test" 가 날아갈 메시지
        peripheral?.post(duration: 1, "Test")
    }
    
    private func stop() {
        if peripheral.isAdvertising, BluetoothPeripheral.hasPermission {
            peripheral?.stop()
        }
    }
    
    
    
}

