//
//  BoardManager.swift
//  WordGuessingGame
//
//  Created by Eric on 4/17/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import UIKit

class BoardManager {
    let boardUIView: UIView!
    let viewController: UIViewController!
    init(viewController:UIViewController,
         boardUIView: UIView,
         wordArray: [String]) {
        self.boardUIView = boardUIView
        self.viewController = viewController
        
        let letterArray: [String] = wordArray
        
        for letter in letterArray {
            let block: BlockUIView = BlockUIView(letter: letter)
            block.delegate = viewController as? BlockUIViewDelegate
            boardUIView.addSubview(block)
        }
    }
    
    func removeAll() {
        for block in boardUIView.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
    }
}
