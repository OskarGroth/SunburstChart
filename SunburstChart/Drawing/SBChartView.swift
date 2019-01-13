//
//  SBChartView.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class SBChartView: NSView {
    
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
    
    public func showSomeNodes() {
        let node = ChartNode(model: .init(identifier: "node 1", size: 0.2, start: 0.75, color: .orange))
        node.frame = CGRect(x: 300, y: 300, width: node.frame.width, height: node.frame.height)
        layer?.addSublayer(node)
    }
    
    override public func mouseDown(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        guard let node = layer?.sublayers?.first(where: { $0.contains($0.convert(point, from: layer!)) }) as? ChartNode else { return }
        node.runHitAnimation()
    }
    
    override public func mouseMoved(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        let sublayers = layer!.sublayers!
        guard let node = sublayers.first(where: { $0.contains($0.convert(point, from: layer!)) }) as? ChartNode else { return }
        node.runHitAnimation()
    }

}