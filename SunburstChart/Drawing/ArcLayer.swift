//
//  ArcLayer.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class ArcLayer: CAShapeLayer, CAAnimationDelegate {
    
    var model: ArcLayout!
    
    var currentScale: CGFloat {
        return (superlayer as? ArcContainerLayer)?.scale ?? 1.0
    }
        
    override public init() {
        super.init()
        commonInit()
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)
        commonInit()
    }
    
    public func update(_ model: ArcLayout, animated: Bool = false) {
        self.model = model
        if animated {
            /*let animation = CAKeyframeAnimation(keyPath: "path")
            animation.values = Array(1...100).map({
                let div = CGFloat($0)/100
                let size = model.endAngle-model.startAngle
                let incr = div * size
                return CGPath.makeArc(startAngle: model.startAngle, endAngle: model.startAngle+incr, radius: model.radius, width: model.width)
            })
            animation.keyTimes = Array(0...100).map({
                NSNumber(value: Float($0)/100)
            })
            animation.duration = 1
            add(animation, forKey: "path")
            path = animation.values?.last as! CGPath*/
        } else {
            path = CGPath.makeArc(startAngle: model.startAngle, endAngle: model.endAngle, radius: model.radius, width: model.width)
        }
    }
    
    func commonInit() {
        lineWidth = 1
        shouldRasterize = false
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
        let scale = currentScale
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(.init(name: .easeInEaseOut))
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale", from: scale, to: scale*0.98, duration: 0.2, autoreverses: true)
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
