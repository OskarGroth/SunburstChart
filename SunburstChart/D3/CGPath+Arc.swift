//
//  CGPath+Arc.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

extension CGPath {
    
    /// Returns the path of a closed arc with a given width between two angles at a given radius.
    /// - Parameters:
    ///   - startAngle: The starting angle.
    ///   - endAngle: The end angle.
    ///   - radius: The inner radius of the arc.
    ///   - width: The width of the arc.
    static func makeArc(startAngle: CGFloat, endAngle: CGFloat, radius: CGFloat, width: CGFloat) -> CGPath {
        let arcPath = CGMutablePath()
        arcPath.addRelativeArc(center: .zero, radius: radius, startAngle: -startAngle, delta: -(endAngle-startAngle), transform: CGAffineTransform(rotationAngle: .pi/2))
        let closedPath = CGMutablePath()
        closedPath.addPath(arcPath.copy(strokingWithWidth: width, lineCap: .butt, lineJoin: .miter, miterLimit: 10))
        closedPath.closeSubpath()
        return closedPath
    }
    
}
