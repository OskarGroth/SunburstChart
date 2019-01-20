//
//  ArcChartView.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-13.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class ArcChartView: NSView {
    
    static let defaultSize: CGFloat = 500.0

    var hoverArc: ArcLayer?
    
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    public func addArc(_ arc: ArcLayer) {
        layer?.addSublayer(arc)
        layer?.resizeSublayers(withOldSize: layer!.bounds.size)
    }
    
    func commonInit() {
        wantsLayer = true
        layer = ArcContainerLayer()
    }
    
    override public func updateTrackingAreas() {
        trackingAreas.forEach({ removeTrackingArea($0) })
        addTrackingArea(NSTrackingArea(rect: bounds, options: [.activeInKeyWindow, .mouseMoved, .inVisibleRect], owner: self, userInfo: nil))
    }

    override public func mouseDown(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        guard let arc = layer?.sublayers?.first(where: { $0.contains($0.convert(point, from: layer!)) }) as? ArcLayer else { return }
        arc.runHitAnimation()
    }
    
    override public func mouseMoved(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        let arc = layer?.sublayers?.first(where: { $0.contains($0.convert(point, from: layer!)) }) as? ArcLayer
        if arc != hoverArc {
            hoverArc?.removeAllAnimations()
            hoverArc = arc
            arc?.runHoverAnimation()
        }
    }

}
