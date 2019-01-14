//
//  Partition.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

extension Node {
    
    func eachBefore(callback: ((inout Node) -> Void)){
        var node = self
        var nodes = [node]
        var children = self.children
        while !nodes.isEmpty {
            node = nodes.removeLast()
            callback(&node)
            children = node.children
            if !children.isEmpty {
                for child in children.reversed() {
                    nodes.append(child)
                }
            }
        }
    }
    
}

class Partition {
 
    var round: Bool = false
    var padding: CGFloat = 0
    
    private var dx: CGFloat = 1
    private var dy: CGFloat = 1
    
    func partition(root: inout Node) -> Node {
        let n = root.height + 1
        root.x0 = padding
        root.y0 = padding
        root.x1 = dx
        root.y1 = dy/CGFloat(n)
        root.eachBefore(callback: positionNode(dy: dy, n: n, padding: padding))
        //if round { root.eachBefore(callback: { roundNode }) }
        return root
    }
    
    func treemapDice(parent: inout Node, x0: CGFloat, y0: CGFloat, x1: CGFloat, y1: CGFloat) {
        let nodes = parent.children
        var node: Node
        var i = -1
        let n = nodes.count
        let k = parent.size == 0 ? 0 : (x1 - x0) / parent.size
        while i < n {
            i += 1
            node = nodes[i]
            node.y0 = y0
            node.y1 = y1
            node.x0 = x0
            node.x1 = x0 + node.size*k // TODO: Unsure: node.x1 = x0 += node.value * k
        }
    }
    
    func positionNode(dy: CGFloat, n: Int, padding: CGFloat) -> ((inout Node) -> Void) {
        return { node in
            if !node.children.isEmpty {
                //treemapdice
            }
            var x0 = node.x0
            var y0 = node.y0
            var x1 = node.x1 - padding
            var y1 = node.y1 - padding
            if x1 < x0 {
                let mid = (x0 + x1)/2
                x0 = mid; x1 = mid;
            }
            if y1 < y0 {
                let mid = (y0 + y1)/2
                y0 = mid; y1 = mid;
            }
            node.x0 = x0
            node.y0 = y0
            node.x1 = x1
            node.y1 = y1
        }
    }
    

    func setSize(x: CGFloat, y: CGFloat) {
        dx = x
        dy = y
    }
    
    
}
