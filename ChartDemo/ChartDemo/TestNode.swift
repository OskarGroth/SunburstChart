//
//  TestNode.swift
//  ChartDemo
//
//  Created by Oskar Groth on 2019-01-18.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation
import SunburstChart

final class TestNode: ArcNode {
    
    var name: String
    var size: CGFloat
    var children: [TestNode]
    var parent: TestNode?
    var height: Int
    var depth: Int
    /*var depth: Int {
        var h = 0
        var p = parent
        while p != nil {
            h += 1
            p = p?.parent
        }
        return h
    }*/
    var layout: ArcLayout
    var style: ArcStyle?
    var identifier: String
    
    var hashValue: Int {
        return identifier.hashValue
    }
    
    init(identifier: String, name: String, size: CGFloat, children: [TestNode] = [], parent: TestNode? = nil, depth: Int = 0, style: ArcStyle? = nil) {
        self.identifier = identifier
        self.name = name
        self.size = size
        self.children = children
        self.parent = parent
        self.depth = depth
        self.style = style
        self.layout = ArcLayout(startAngle: 0, endAngle: 0, radius: 0, width: 0)
        height = 0
    }
    
    static func == (lhs: TestNode, rhs: TestNode) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func < (lhs: TestNode, rhs: TestNode) -> Bool {
        if lhs.size == rhs.size { return lhs.name < rhs.name }
        return lhs.size < rhs.size
    }
    
    static func > (lhs: TestNode, rhs: TestNode) -> Bool {
        if lhs.size == rhs.size { return lhs.name > rhs.name }
        return lhs.size > rhs.size
    }
    
}
