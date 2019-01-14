//
//  ChartNode.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class ChartNode: CAShapeLayer, CAAnimationDelegate {
    
    public struct Model: Identifiable {
        
        /// The fraction of the size compared to the parent node. From 0.0 to 1.0.
        public var size: CGFloat
        
        /// The fraction of the size of all predecessing nodes on this arc. From 0.0 to 1.0.
        public var start: CGFloat
        
        /// The color of the node.
        public var color: NSColor
      
        /// Unique identifier
        public var identifier: String
        
        /// :nodoc:
        public var hashValue: Int {
            return identifier.hashValue
        }
        
        /// A plain initializer to be used with a standard `ChartNodeModel`.
        ///
        /// - Parameters:
        ///   - identifier: A string that uniquely identifies this cell model within the table view.
        ///   - size: The size of this node.
        ///   - start: The starting fraction of this node.
        ///   - color: The color for this node.
        public init(identifier: String, size: CGFloat, start: CGFloat, color: NSColor) {
            self.identifier = identifier
            self.size = size
            self.color = color
            self.start = start
        }
        
        /// :nodoc:
        public static func == (lhs: Model, rhs: Model) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    
    }
    
    public override var description: String {
        return "Node \(String(describing: model.identifier))"
    }
    
    public var model: Model!
    private var closedPath: CGPath!
    
    public init(model: Model) {
        super.init()
        commonInit()
        setup(model)
    }
    
    override public init() {
        super.init()
        commonInit()
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)
        commonInit()
    }
    
    func commonInit() {
        lineWidth = 40
        lineCap = .butt
        strokeStart = 0
        strokeEnd = 0
        fillColor = NSColor.clear.cgColor
    }
    
    func setup(_ model: Model) {
        self.model = model
        strokeColor = model.color.cgColor
        let cgPath = CGMutablePath()
        cgPath.addArc(center: .zero, radius: 100, startAngle: .pi * 2 * model.start, endAngle: .pi * 2 * model.size, clockwise: true, transform: CGAffineTransform(rotationAngle: .pi/2))
        path = cgPath
        closedPath = path?.copy(strokingWithWidth: 40, lineCap: .butt, lineJoin: .miter, miterLimit: 0)
        animate(model.size)
    }
    
    override public func contains(_ p: CGPoint) -> Bool {
        return closedPath.contains(p)
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
        let fadeAnimation = CABasicAnimation(keyPath: "strokeColor", from: strokeColor, to: model.color.darkerColor.cgColor, duration: 0.1, autoreverses: true)
        add(scaleAnimation, forKey: "scale")
        add(fadeAnimation, forKey: "color")
        CATransaction.commit()
    }
    
    func runHoverAnimation() {
        add(CABasicAnimation(keyPath: "strokeColor", from: strokeColor, to: model.color.lighterColor.cgColor, duration: 0.25, timing: .easeInEaseOut, autoreverses: true, repeatCount: .infinity), forKey: "color")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
