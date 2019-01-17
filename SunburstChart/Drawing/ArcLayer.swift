//
//  ArcLayer.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class ArcLayer: CAShapeLayer, CAAnimationDelegate {
    
    override public init() {
        super.init()
        commonInit()
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)
        commonInit()
    }
    
    func commonInit() {
        lineWidth = 1
        shouldRasterize = true
        rasterizationScale = 4 * NSScreen.main!.backingScaleFactor
    }
    
    override public func contains(_ p: CGPoint) -> Bool {
        return path?.contains(p) ?? false
    }
    
    func animate(_ size: CGFloat) {
        strokeEnd = 0
        removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = CFTimeInterval(1.2)
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        strokeEnd = 1.0
        add(animation, forKey: "strokeEnd")
    }
    
    func runHitAnimation() {
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(.init(name: .easeInEaseOut))
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale", from: 1.0, to: 0.99, duration: 0.2, autoreverses: true)
        let fadeAnimation = CABasicAnimation(keyPath: "fillColor", from: fillColor, to: NSColor(cgColor: fillColor!)!.darkerColor.cgColor, duration: 0.1, autoreverses: true)
        add(scaleAnimation, forKey: "scale")
        add(fadeAnimation, forKey: "color")
        CATransaction.commit()
    }
    
    func runHoverAnimation() {
        add(CABasicAnimation(keyPath: "fillColor", from: fillColor, to: NSColor(cgColor: fillColor!)!.lighterColor.cgColor, duration: 0.25, timing: .easeInEaseOut, autoreverses: true, repeatCount: .infinity), forKey: "color")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
