//
//  HelpViewController.swift
//  WordGuessingGame
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit
import MaterialMotion

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        transitionController.transitionType = PushBackTransition.self
        
        let pan = UIPanGestureRecognizer()
        transitionController.dismisser.dismissWhenGestureRecognizerBegins(pan)
        view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private class PushBackTransition: Transition {
        
        required init() {}
        
        func willBeginTransition(withContext ctx: TransitionContext, runtime: MotionRuntime) -> [Stateful] {
            let draggable = Draggable(withFirstGestureIn: ctx.gestureRecognizers)
            
            runtime.add(ChangeDirection(withVelocityOf: draggable.nextGestureRecognizer, whenNegative: .forward),
                        to: ctx.direction)
            
            let bounds = ctx.containerView().bounds
            let backPosition = CGPoint(x: bounds.midX, y: bounds.maxY + ctx.fore.view.bounds.height / 2)
            let forePosition = CGPoint(x: bounds.midX, y: bounds.midY)
            let movement = TransitionSpring(back: backPosition,
                                            fore: forePosition,
                                            direction: ctx.direction)
            
            let scale = runtime.get(ctx.back.view.layer).scale
            
            let tossable = Tossable(spring: movement, draggable: draggable)
            
            runtime.connect(runtime.get(ctx.fore.view.layer).position.y()
                .rewriteRange(start: movement.backwardDestination.y,
                              end: movement.forwardDestination.y,
                              destinationStart: 1,
                              destinationEnd: 0.95),
                            to: scale)
            
            runtime.add(tossable, to: ctx.fore.view) { $0.xLocked(to: bounds.midX) }
            
            return [tossable]
        }
    }
}
