//
//  SBChartView.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class SBChartView: NSView {
    
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
    
    public func showSomeNodes() {
        let node = ChartNode(model: .init(identifier: "node 1", size: 0.75, level: 1, start: 0, color: .orange))
        node.frame = CGRect(x: 300, y: 300, width: node.frame.width, height: node.frame.height)
        layer?.addSublayer(node)
        
        let node2 = ChartNode(model: .init(identifier: "node 2", size: 0.4, level: 2, start: 0, color: .green))
        node2.frame = CGRect(x: 300, y: 300, width: node.frame.width, height: node.frame.height)
        layer?.addSublayer(node2)
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
