//
//  ArcStyle.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-18.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public struct ArcStyle {
    
    var color: NSColor
    var display: Bool

    init(color: NSColor = .green, display: Bool = true) {
        self.color = color
        self.display = display
    }
    
}
