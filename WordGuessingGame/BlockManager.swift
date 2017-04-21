//
//  BlockManager
//  WordGuessingGame
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

class BlockManager {
    var blocks: [BlockUIView] = []
    var word = "";
    var currentWord = ""
    let viewController: UIViewController!
    let blockHolder: UIView!
    let blockHolderWidth: NSLayoutConstraint!
    
    init(
      viewController:UIViewController,
      word: String,
      blockHolder: UIView,
      widthConstraint: NSLayoutConstraint) {
        self.viewController = viewController
        self.word = word
        self.blockHolder = blockHolder
        self.blockHolderWidth = widthConstraint
    }
    
    func add(_ block: BlockUIView) {
        blocks.append(block)
        
        currentWord = ""
        var width = CGFloat(0)
        for blockItem in blocks {
            blockItem.frame.origin = CGPoint(x: width, y: 0)
            width += 50
            currentWord += blockItem.letterLabel.text!
            blockHolder.addSubview(block)
        }
        blockHolderWidth.constant = width
        if currentWord == word {
          let alert = UIAlertController(title: "You Won", message: "Word Matched", preferredStyle: UIAlertControllerStyle.alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func removeAll() {
        for block in blockHolder.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
        blockHolderWidth.constant = 0
    }
}
