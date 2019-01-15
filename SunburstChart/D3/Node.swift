//
//  Node.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class Node {
    
    var x0: CGFloat = 0 // start angle
    var y0: CGFloat = 0 // inner radius
    var x1: CGFloat = 0 // end angle
    var y1: CGFloat = 0 // outer radius
    
    var name: String
    var size: CGFloat
    var children: [Node]
    var height: Int = 0
    
    var parent: Node?
    var depth: Int {
        var h = 0
        var p = parent
        while p != nil {
            h += 1
            p = p?.parent
        }
        return h
    }
    
    init(name: String, size: CGFloat, children: [Node]) {
        self.name = name
        self.size = size
        self.children = children
    }
    
}
