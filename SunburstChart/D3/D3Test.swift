//
//  D3Test.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

extension Node {

    
    func descendants() -> [Node] {
        var nodes = [Node]()
        var node: Node? = self
        var current: [Node]
        var next = [node]
        var children: [Node]
        repeat {
            current = next.reversed().compactMap({ $0 })
            next = []
            node = current.popLast()
            while node != nil {
                nodes.append(node!)
                children = node!.children
                if !children.isEmpty {
                    for child in children {
                        next.append(child)
                    }
                }
                node = current.popLast()
            }
        } while next.count > 0
        //return self
        return nodes
    }
    
}

extension SBChartView {
    
    static let nodeData: Node = {
        let a = Node(name: "Topic A", size: 8, children: [Node(name: "Sub A1", size: 4, children: []), Node(name: "Sub A2", size: 4, children: [])])
        let b = Node(name: "Topic B", size: 9, children: [Node(name: "Sub B1", size: 3, children: []), Node(name: "Sub B2", size: 3, children: []), Node(name: "Sub B3", size: 3, children: [])])
        let c = Node(name: "Topic C", size: 8, children: [Node(name: "Sub C1", size: 4, children: []), Node(name: "Sub C2", size: 4, children: [])])
        let node = Node(name: "TOPICS", size: 25, children: [a, b, c])
        
        func assignParents(n: Node) -> Int {
            var heights = [Int]()
            for child in n.children {
                child.parent = n
                heights.append(1 + assignParents(n: child))
                child.height = heights.last! - 1
            }
            return heights.max() ?? 0
        }
        node.height = assignParents(n: node)
        return node
    }()
    
    static var radius: CGFloat = 250.0
    
    public func d3Test() {
        var partition = Partition()
        partition.setSize(x: 2 * CGFloat.pi, y: SBChartView.radius)

        var root = SBChartView.nodeData
        partition.partition(root: &root)
        
        let nodes = root.descendants()
        
        for node in nodes {
            print("\n\(node.name)\n Size: (\(node.size)): Depth: \(node.depth) Height: \(node.height)\nx0: \(node.x0)\nx1: \(node.x1) \ny0: \(node.y0)\ny1: \(node.y1)")
            let chartNode = ChartNode()
           // chartNode.setup(.init(identifier: node.name, size: node., level: node.depth, start: node.x1, color: <#T##NSColor#>))
            chartNode.setup(startAngle: node.x0, endAngle: node.x1, innerRadius: node.y0, outerRadius: node.y1)
            chartNode.frame = CGRect(x: 300, y: 300, width: chartNode.frame.width, height: chartNode.frame.height)
            if node.depth == 0 {
                chartNode.strokeColor = NSColor.clear.cgColor
            } else {
                chartNode.strokeColor = NSColor.random().cgColor
            }
            chartNode.fillColor = NSColor.clear.cgColor
            chartNode.name = node.name
            self.layer?.addSublayer(chartNode)
        }
        
    }
    
}

extension NSColor {
    class func random() -> NSColor {
        let red =   UInt32.random(in: 0...255)
        let green = UInt32.random(in: 0...255)
        let blue =  UInt32.random(in: 0...255)
        let color = NSColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1.0)
        return color
    }
}
