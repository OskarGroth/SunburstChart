//
//  ArcLayout.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-18.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public struct ArcLayout {
    
    let startAngle: CGFloat
    let endAngle: CGFloat
    let radius: CGFloat
    let width: CGFloat
    
    public init(startAngle: CGFloat = 0, endAngle: CGFloat = 0, radius: CGFloat = 0, width: CGFloat = 0) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.radius = radius
        self.width = width
    }
    
}

extension ArcLayout: Hashable {
    
    /// :nodoc:
    public static func == (lhs: ArcLayout, rhs: ArcLayout) -> Bool {
        return lhs.startAngle == rhs.startAngle
            && lhs.endAngle == rhs.endAngle
            && lhs.radius == rhs.radius
            && lhs.width == rhs.width
    }
    
}
