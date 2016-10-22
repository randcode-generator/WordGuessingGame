//
//  BlockUIView.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

protocol BlockUIViewDelegate: class {
    func didTouchBucket(_ block: BlockUIView, origin: CGPoint) -> Bool;
}

class BlockUIView: UIView {
    var shouldListenToEvents: Bool = true;
    let letterLabel: UILabel = UILabel();
    let backgroundImage: UIImageView = UIImageView();
    weak var delegate: BlockUIViewDelegate?
    
    init(letter: String) {
        let x = CGFloat(arc4random_uniform(300)) + 10
        let y = CGFloat(arc4random_uniform(300)) + 10
        super.init(frame: CGRect(x: x, y: y, width: 45, height: 45));
        
        backgroundImage.image = UIImage(named: "wood");
        backgroundImage.frame = CGRect(x: 0, y: 0, width: 45, height: 45);
    
        letterLabel.text = letter;
        letterLabel.font = letterLabel.font.withSize(32);
        letterLabel.textAlignment = NSTextAlignment.center;
        letterLabel.textColor = UIColor.white;
        letterLabel.frame = CGRect(x: 0, y: 0, width: 45, height: 45);
    
        addSubview(backgroundImage);
        addSubview(letterLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldListenToEvents == false {
            return;
        }
        
        let touch = touches.first;
        let point = touch?.location(in: self.superview);
        self.center = point!;
        let didtouch = delegate?.didTouchBucket(self, origin: self.frame.origin);
        if (didtouch != nil && didtouch == true) {
            shouldListenToEvents = false;
        }
    }
}
