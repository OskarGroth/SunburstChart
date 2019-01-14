//
//  CAAnimation+Extensions.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

extension CABasicAnimation {
    
    convenience init(keyPath: String, from: Any? = nil, to: Any? = nil, duration: TimeInterval, timing: CAMediaTimingFunctionName = .default, autoreverses: Bool = false, repeatCount: Float = 0) {
        self.init(keyPath: keyPath)
        self.fromValue = from
        self.toValue = to
        self.duration = duration
        self.autoreverses = autoreverses
        self.repeatCount = repeatCount
        self.timingFunction = CAMediaTimingFunction(name: timing)
    }
    
}

extension CAAnimation {
    /// A block (closure) object to be executed when the animation starts. This block has no return value and takes no argument.
    var start: (() -> Void)? {
        set {
            if let animationDelegate = delegate as? CAAnimationHandler {
                animationDelegate.start = newValue
            } else {
                let animationDelegate = CAAnimationHandler()
                animationDelegate.start = newValue
                delegate = animationDelegate
            }
        }
        
        get {
            if let animationDelegate = delegate as? CAAnimationHandler {
                return animationDelegate.start
            }
            
            return nil
        }
    }
    
    /// A block (closure) object to be executed when the animation ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished.
    var completion: ((Bool) -> Void)? {
        set {
            if let animationDelegate = delegate as? CAAnimationHandler {
                animationDelegate.completion = newValue
            } else {
                let animationDelegate = CAAnimationHandler()
                animationDelegate.completion = newValue
                delegate = animationDelegate
            }
        }
        
        get {
            if let animationDelegate = delegate as? CAAnimationHandler {
                return animationDelegate.completion
            }
            
            return nil
        }
    }
    
    /// A block (closure) object to be executed when the animation is animating. This block has no return value and takes a single CGFloat argument that indicates the progress of the animation (From 0 ..< 1)
    var animating: ((CGFloat) -> Void)? {
        set {
            if let animationDelegate = delegate as? CAAnimationHandler {
                animationDelegate.animating = newValue
            } else {
                let animationDelegate = CAAnimationHandler()
                animationDelegate.animating = newValue
                delegate = animationDelegate
            }
        }
        
        get {
            if let animationDelegate = delegate as? CAAnimationHandler {
                return animationDelegate.animating
            }
            
            return nil
        }
    }
    
    /// Alias to `animating`
    var progress: ((CGFloat) -> Void)? {
        set {
            animating = newValue
        }
        
        get {
            return animating
        }
    }
}

extension CALayer {
    /**
     Add the specified animation object to the layer’s render tree. Could provide a completion closure.
     
     - parameter anim:       The animation to be added to the render tree. This object is copied by the render tree, not referenced. Therefore, subsequent modifications to the object are not propagated into the render tree.
     - parameter key:        A string that identifies the animation. Only one animation per unique key is added to the layer. The special key kCATransition is automatically used for transition animations. You may specify nil for this parameter.
     - parameter completion: A block object to be executed when the animation ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. Default value is nil.
     */
    func add(_ animation: CAAnimation, forKey key: String?, withCompletion completion: ((Bool) -> Void)?) {
        animation.completion = completion
        add(animation, forKey: key)
    }
}
