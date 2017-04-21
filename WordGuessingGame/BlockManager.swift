//
//  BlockManager
//  WordGuessingGame
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit
import MaterialMotion

class BlockManager {
    var blocks: [BlockUIView] = []
    var word = "";
    var currentWord = ""
    let viewController: UIViewController!
    let blockHolder: UIView!
    let blockHolderWidth: NSLayoutConstraint!
    var runtime: MotionRuntime! = nil
    
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
    
    func setRuntime(runtime: MotionRuntime) {
        self.runtime = runtime
    }
    
    func add(_ block: BlockUIView) {
        block.frame.origin = CGPoint(x: 0, y: 0)
        block.removeFromSuperview()
        
        let interactions = runtime.interactions(for: block) {
            $0 as? Draggable
        };
            
        for(_, value) in interactions.enumerated() {
            value.enabled.value = false
        }
        blocks.append(block)
        
        currentWord = ""
        var width = CGFloat(0)
        for blockItem in blocks {
            let arcMove = ArcMove()
            arcMove.from.value = blockItem.frame.origin
            arcMove.to.value = CGPoint(x: width, y: 0)
            runtime.add(arcMove, to: blockItem)
            runtime.get(blockItem.layer).anchorPoint.value = CGPoint(x: 0, y: 0)
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
