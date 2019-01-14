//
//  SBChartView.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class SBChartView: NSView {
    
    var data: NSTreeNode? {
        didSet {
            reloadData()
        }
    }
    var hoverNode: ChartNode?
    
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    func commonInit() {
        wantsLayer = true
    }
    
    override public func updateTrackingAreas() {
        trackingAreas.forEach({ removeTrackingArea($0) })
        addTrackingArea(NSTrackingArea(rect: bounds, options: [.activeInKeyWindow, .mouseMoved, .inVisibleRect], owner: self, userInfo: nil))
    }
    
    public func reloadData() {
        layer?.sublayers?.removeAll()
        
    }
    
    public func showSomeNodes() {
        let colors = [NSColor.blue, NSColor.orange, NSColor.yellow, NSColor.green, NSColor.cyan, NSColor.magenta]
        for i in 0...400 {
            DispatchQueue.main.async {
                let node = ChartNode(model: .init(identifier: "node \(i)", size: CGFloat(arc4random_uniform(100))/100, level: Int(arc4random_uniform(10)), start: 0, color: colors[Int(arc4random_uniform(6))]))
                node.frame = CGRect(x: 300, y: 300, width: node.frame.width, height: node.frame.height)
                self.layer?.addSublayer(node)
            }

        }
        
    }
    
    override public func mouseDown(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        guard let node = layer?.sublayers?.first(where: { $0.contains($0.convert(point, from: layer!)) }) as? ChartNode else { return }
        node.runHitAnimation()
    }
    
    override public func mouseMoved(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        let node = layer?.sublayers?.first(where: { $0.contains($0.convert(point, from: layer!)) }) as? ChartNode
        if node != hoverNode {
            hoverNode?.removeAllAnimations()
            hoverNode = node
            node?.runHoverAnimation()
        }
    }

}
