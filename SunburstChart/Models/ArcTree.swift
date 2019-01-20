//
//  ArcTree.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-19.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public struct TreePartition<T: ArcNode> {
    
    public typealias LayoutChangeSet = [Int: ArcLayout]
    
    let padding: CGFloat = 0
    let dx: CGFloat = 2 * .pi
    let dy: CGFloat
    let n: CGFloat
    
    public var nodes: [T]
    
    public init(root: T, size: CGFloat) {
        dy = size
        n = CGFloat(root.height + 1)
        var node = root
        var nodes = [node]
        var stack: [T] = [node]
        while !nodes.isEmpty {
            node = nodes.removeLast()
            for child in node.children.sorted(by: >) {
                nodes.append(child)
                stack.append(child)
            }
        }
        self.nodes = stack
    }
    
    public func calculateLayoutChanges() -> LayoutChangeSet {
        guard !nodes.isEmpty else { return LayoutChangeSet() }
        var layouts = LayoutChangeSet()
        let n = CGFloat(nodes[0].height + 1)
        let rootLayout = ArcLayout(startAngle: padding, endAngle: dx, radius: padding, width: dy/n - padding)
        if nodes[0].layout != rootLayout {
            layouts[0] = rootLayout
        }
        for (index, node) in nodes.enumerated() {
            positionNode(node, layouts: &layouts, index: index)
        }
        return layouts
    }
    
    func positionNode<T: ArcNode>(_ node: T, layouts: inout LayoutChangeSet, index: Int) {
        let layout = layouts[index] ?? node.layout
  
        if !node.children.isEmpty {
            treemapDice(parent: node, layouts: &layouts, x0: layout.startAngle, x1: layout.endAngle, y0: dy * CGFloat(node.depth + 1) / n, y1: dy * CGFloat(node.depth + 2) / n)
        }
        var x0: CGFloat = layout.startAngle
        var x1: CGFloat = layout.endAngle - padding
        var y0: CGFloat = layout.radius
        var y1: CGFloat = layout.radius + layout.width - padding
        x1 -= padding
        y1 -= padding
        if x1 < x0 {
            x0 = (x0 + x1)/2
            x1 = x0
        }
        if y1 < y0 {
            y0 = (y0 + y1)/2
            y1 = y0
        }
        let newLayout = ArcLayout(startAngle: x0, endAngle: x1, radius: y0, width: y1-y0)
        if node.layout != newLayout {
            layouts[index] = newLayout
        }
    }
    
    func treemapDice<T: ArcNode>(parent: T, layouts: inout LayoutChangeSet, x0: CGFloat, x1: CGFloat, y0: CGFloat, y1: CGFloat) {
        let children = parent.children
        var node: T
        var i = -1
        let n = children.count
        let k = parent.size == 0 ? 0 : (x1 - x0) / parent.size
        var nextX0 = x0
        while i < n-1 {
            i += 1
            node = children[i]
            let nodeX0 = nextX0
            nextX0 += node.size*k
            let layout = ArcLayout(startAngle: nodeX0, endAngle: nextX0, radius: y0, width: y1-y0)
            if node.layout != layout {
                /// TODO: Performance
                let index = nodes.firstIndex(where: { $0 == node })!
                layouts[index] = layout
            }
        }
    }
    
}
