//
//  Node.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class Node {
    
    var x0: CGFloat = 0
    var y0: CGFloat = 0
    var x1: CGFloat = 0
    var y1: CGFloat = 0
    
    var name: String
    var size: CGFloat
    var children: [Node]
    
    var parent: Node?
    var height: Int {
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
