//
//  LottieView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/13.
//

import Foundation
import SwiftUI
import Lottie
// SwiftUI에서 사용하기 위헤 UIKit을 import해주세요
import UIKit

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var name: String
    var loopMode: LottieLoopMode
    var completion: (Bool) -> Void
    
    init(jsonName: String, loopMode: LottieLoopMode = .playOnce, completion: @escaping (Bool) -> Void) {
        self.name = jsonName
        self.loopMode = loopMode
        self.completion = completion
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: name)
        
        // AspectFit으로 적절한 크기의 에니매이션을 불러옵니다.
        animationView.contentMode = .scaleAspectFit
        // 애니메이션은 기본으로 Loop합니다.
        animationView.loopMode = loopMode
        animationView.play { finish in
            self.completion(finish)
        }
        animationView.backgroundBehavior = .pauseAndRestore
        
        // 컨테이너의 너비와 높이를 자동으로 지정할 수 있도록합니다. 로티는 컨테이너 위에 작성됩니다. /
        animationView.translatesAutoresizingMaskIntoConstraints = false
          
          view.addSubview(animationView)
           // 레이아웃의 높이와 넓이의 제약
          NSLayoutConstraint.activate([
              animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
              animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
          ])

          return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
