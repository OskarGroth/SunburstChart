//
//  D3Test.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation


extension SBChartView {
    
    static let nodeData: Node = {
        let a = Node(name: "Topic A", size: 8, children: [Node(name: "Sub A1", size: 4, children: [Node(name: "Sub A2", size: 4, children: [])])])
        let b = Node(name: "Topic B", size: 9, children: [Node(name: "Sub B1", size: 3, children: [Node(name: "Sub B2", size: 3, children: [Node(name: "Sub B3", size: 3, children: [])])])])
        let c = Node(name: "Topic C", size: 8, children: [Node(name: "Sub A1", size: 4, children: [Node(name: "Sub A2", size: 4, children: [])])])
        let node = Node(name: "TOPICS", size: 25, children: [a, b, c])
        
        func assignParents(n: Node) {
            for child in n.children {
                child.parent = n
                assignParents(n: child)
            }
        }
        assignParents(n: node)
        return node
    }()
    
    static var radius: CGFloat = 300.0
    
    func d3Test() {
        
        var partition = Partition()
        partition.setSize(x: 2 * CGFloat.pi, y: SBChartView.radius)
        
        var root = SBChartView.nodeData
        partition.partition(root: &root)
        
        //d3.arc
        
    }
    
}
