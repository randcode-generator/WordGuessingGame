//
//  BoardManager.swift
//  WordGuessingGame
//
//  Created by Eric on 4/17/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import UIKit
import MaterialMotion
import IndefiniteObservable

class BoardManager {
    let boardUIView: UIView!
    let viewController: UIViewController!
    var subscriptions: [Subscription] = []
    var runtime: MotionRuntime!
    
    init(viewController:UIViewController,
         boardUIView: UIView,
         wordArray: [String]) {
        self.boardUIView = boardUIView
        self.viewController = viewController
        
        let letterArray: [String] = wordArray
        runtime = MotionRuntime(containerView: boardUIView)
        for letter in letterArray {
            let block: BlockUIView = BlockUIView(letter: letter)
            runtime.add(Draggable(), to: block)
            boardUIView.addSubview(block)
            
            subscriptions.append(runtime.get(block.layer).position.subscribeToValue {
                (p: CGPoint) in
                (viewController as! ViewController).didTouchBucket(block, origin: p)
            })
        }
    }
    
    func getRuntime() -> MotionRuntime {
        return runtime
    }
    
    func removeAll() {
        for block in boardUIView.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
    }
}
