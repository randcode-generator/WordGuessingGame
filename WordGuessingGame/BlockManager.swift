//
//  BlockManager
//  WordGuessingGame
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

protocol BlockManagerDelegate: class {
    func wordMatched()
}

class BlockManager {
    var blocks: [BlockUIView] = []
    var word = "";
    var currentWord = ""
    weak var delegate: BlockManagerDelegate?
    let blockHolder: UIView!
    let blockHolderWidth: NSLayoutConstraint!
    
    init(word: String, blockHolder: UIView, widthConstraint: NSLayoutConstraint) {
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
            self.delegate?.wordMatched()
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
