//
//  Arc.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

struct Arc {
    
    var path: CGPath
    var closedPath: CGPath
    
    init(startAngle: CGFloat, endAngle: CGFloat, innerRadius: CGFloat, outerRadius: CGFloat) {
        let cgPath = CGMutablePath()
        cgPath.addArc(center: .zero, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true, transform: CGAffineTransform(rotationAngle: .pi/2))
        path = cgPath
        closedPath = path.copy(strokingWithWidth: outerRadius-innerRadius, lineCap: .butt, lineJoin: .miter, miterLimit: 0)
        
    }
    
}
