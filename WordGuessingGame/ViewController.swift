//
//  ViewController.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BlockUIViewDelegate, BlockManagerDelegate {
    
    var blockManager: BlockManager?
    var wordList: WordList = WordList()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        colorAndBorderButton()
        startOver()
    }
    
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var StartOverButton: UIButton!
    @IBOutlet weak var bucketImage: UIImageView!
    @IBOutlet weak var blockHolder: UIView!
    
    @IBAction func startOverAction(sender: AnyObject) {
        startOver()
    }
    
    @IBAction func newWordAction(sender: AnyObject) {
        newWord()
    }
    
    func colorAndBorderButton() {
        newWordButton.layer.cornerRadius = 10;
        newWordButton.layer.borderWidth = 2;
        newWordButton.layer.borderColor = UIColor.blueColor().CGColor
        
        StartOverButton.layer.cornerRadius = 10;
        StartOverButton.layer.borderWidth = 2;
        StartOverButton.layer.borderColor = UIColor.blueColor().CGColor
    }
    
    func newWord() {
        removeAllBlocks()
        wordList = WordList()
        initialize()
    }
    
    func startOver() {
        removeAllBlocks()
        initialize()
    }
    
    func initialize() {
        let word = wordList.getRandomWord()
        let wordArray = wordList.getRandomWordAsArray()
        
        blockManager = BlockManager(word: word, blockHolder: blockHolder)
        blockManager!.delegate = self
        let letterArray: [String] = wordArray
        
        for letter in letterArray {
            let block: BlockUIView = BlockUIView(letter: letter)
            block.delegate = self
            self.view.addSubview(block)
        }
    }
    
    func removeAllBlocks() {
        for block in self.view.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
        for block in blockHolder.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
    }
    
    func didTouchBucket(block: BlockUIView, origin: CGPoint) -> Bool {
        if origin.x >= bucketImage.frame.origin.x &&
            origin.x <= bucketImage.frame.origin.x + bucketImage.frame.size.width &&
            origin.y >= bucketImage.frame.origin.y &&
            origin.y <= bucketImage.frame.origin.y + bucketImage.frame.size.height
        {
            blockManager!.add(block);
            return true;
        }
        return false;
    }
    
    func wordMatched() {
        let alert = UIAlertController(title: "You Won", message: "Word Matched", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

