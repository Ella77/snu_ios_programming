//
//  BubbleStorage.swift
//  BubbleTalk
//
//  Created by JSKeum on 2019/12/17.
//  Copyright © 2019 BubbleTalkTeam. All rights reserved.
//

import SwiftUI

struct BubbleBoxView: View {
    var bubbleBox: BubbleBox

    // 탭 옮기는 것만으로 List 안의 for 문이 돌지 않는다.. binding 설정을 해줘야 할듯
    var body: some View {
        List(self.bubbleBox.bubbles) { bubble in
               Text(bubble.text)
        }
        
    }
}

//struct BubbleStorage_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleBoxView()
//    }
//}
