//
//  Partition.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

extension Node {
    
    /*export default function(callback) {
         var node = this, nodes = [node], children, i;
         while (node = nodes.pop()) {
             callback(node), children = node.children;
             if (children) for (i = children.length - 1; i >= 0; --i) {
                nodes.push(children[i]);
             }
         }
     return this;
     }*/
    func eachBefore(callback: ((inout Node) -> Void)){
        var node = self
        var nodes = [node]
        var children: [Node]
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

///  Creates a new partition layout with the default settings: the default sort order is by descending value; the default value accessor assumes each input data is an object with a numeric value attribute; the default children accessor assumes each input data is an object with a children array; the default size is 1×1
class Partition {
 
    var round: Bool = false
    var padding: CGFloat = 0
    
    private var dx: CGFloat = 1
    private var dy: CGFloat = 1
    
    /*
         Runs the partition layout, returning the array of nodes associated with the specified root node. The partition layout is part of D3's family of [[hierarchical layouts|Hierarchy-Layout]]. These layouts follow the same basic structure: the input argument to the layout is the root node of the hierarchy, and the output return value is an array representing the computed positions of all nodes. Several attributes are populated on each node:
 
         parent - the parent node, or null for the root.
         children - the array of child nodes, or null for leaf nodes.
         value - the node value, as returned by the value accessor.
         depth - the depth of the node, starting at 0 for the root.
         x - the minimum x-coordinate of the node position.
         y - the minimum y-coordinate of the node position.
         dx - the x-extent of the node position.
         dy - the y-extent of the node position.
     
        Although the layout has a size in x and y, this represents an arbitrary coordinate system; for example, you can treat x as a radius and y as an angle to produce a radial rather than Cartesian layout
     */
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
    
    /*export default function(parent, x0, y0, x1, y1) {
         var nodes = parent.children,
         node,
         i = -1,
         n = nodes.length,
         k = parent.value && (x1 - x0) / parent.value;
     
         while (++i < n) {
            node = nodes[i], node.y0 = y0, node.y1 = y1;
            node.x0 = x0, node.x1 = x0 += node.value * k;
         }
     }*/
    func treemapDice(parent: inout Node, x0: CGFloat, y0: CGFloat, x1: CGFloat, y1: CGFloat) {
        let nodes = parent.children
        var node: Node
        var i = -1
        let n = nodes.count
        let k = parent.size == 0 ? 0 : (x1 - x0) / parent.size
        var nextX0 = x0
        while i < n-1 {
            i += 1
            node = nodes[i]
            node.y0 = y0
            node.y1 = y1
            node.x0 = nextX0
            nextX0 += node.size*k
            node.x1 = nextX0
        }
    }
    
    func positionNode(dy: CGFloat, n: Int, padding: CGFloat) -> ((inout Node) -> Void) {
        return { node in
            if !node.children.isEmpty {
                //treemapDice(node, node.x0, dy * (node.depth + 1) / n, node.x1, dy * (node.depth + 2) / n);
                self.treemapDice(parent: &node, x0: node.x0, y0: dy * CGFloat(node.depth + 1) / CGFloat(n), x1: node.x1, y1: dy * CGFloat(node.depth + 2) / CGFloat(n))
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
