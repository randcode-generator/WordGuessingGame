//
//  RenderBlocks.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

protocol BlockManagerDelegate: class {
    func wordMatched()
}

class BlockManager {
    var startingX:CGFloat = 50.0
    var blocks: [BlockUIView] = []
    var word = "";
    var currentWord = ""
    weak var delegate: BlockManagerDelegate?
    let blockHolder: UIView
    
    init(word: String, blockHolder: UIView) {
        self.word = word
        self.blockHolder = blockHolder
    }
    
    func add(block: BlockUIView) {
        blocks.append(block)
        
        currentWord = ""
        var x = startingX
        for blockItem in blocks {
            blockItem.frame.origin = CGPointMake(x, 0)
            x += 50
            currentWord += blockItem.letterLabel.text!
            blockHolder.addSubview(block)
        }
        if currentWord == word {
            self.delegate?.wordMatched()
        }
    }
}
