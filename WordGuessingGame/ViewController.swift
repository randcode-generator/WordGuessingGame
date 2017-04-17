//
//  ViewController.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BlockUIViewDelegate, BlockManagerDelegate {
    
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var StartOverButton: UIButton!
    @IBOutlet weak var bucketImage: UIImageView!
    @IBOutlet weak var blockHolder: UIView!
    @IBOutlet weak var blockHolderWidth: NSLayoutConstraint!
    
    var blockManager: BlockManager?
    var boardManager: BoardManager?
    var wordList: WordList = WordList()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorAndBorderButton()
        startOver()
    }
    
    @IBAction func startOverAction(_ sender: AnyObject) {
        startOver()
    }
    
    @IBAction func newWordAction(_ sender: AnyObject) {
        newWord()
    }
    
    func colorAndBorderButton() {
        newWordButton.layer.cornerRadius = 10;
        newWordButton.layer.borderWidth = 2;
        newWordButton.layer.borderColor = UIColor.blue.cgColor
        
        StartOverButton.layer.cornerRadius = 10;
        StartOverButton.layer.borderWidth = 2;
        StartOverButton.layer.borderColor = UIColor.blue.cgColor
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
        
        blockManager = BlockManager(word: word, blockHolder: blockHolder, widthConstraint: blockHolderWidth)
        blockManager?.delegate = self
        
        boardManager = BoardManager(
            viewController: self,
            boardUIView: self.view,
            wordArray: wordArray)
    }
    
    func removeAllBlocks() {
        boardManager?.removeAll()
        blockManager?.removeAll()
    }
    
    func didTouchBucket(_ block: BlockUIView, origin: CGPoint) -> Bool {
        let converted = bucketImage.convert(bucketImage.frame.origin, to: bucketImage.superview!.superview!)
        if origin.x >= converted.x &&
            origin.x <= bucketImage.frame.origin.x + bucketImage.frame.size.width &&
            origin.y >= converted.y &&
            origin.y <= converted.y + bucketImage.frame.size.height
        {
            blockManager!.add(block);
            return true;
        }
        return false;
    }
    
    func wordMatched() {
        let alert = UIAlertController(title: "You Won", message: "Word Matched", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

