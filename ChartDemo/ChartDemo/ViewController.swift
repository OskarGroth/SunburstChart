//
//  ViewController.swift
//  ChartDemo
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Cocoa
import SunburstChart
import os

class ViewController: NSViewController {
    
    lazy var chartView = ArcChartView(frame: view.bounds)
    
    static let nodeData: TestNode = {
        let subA1 = TestNode(identifier: UUID().uuidString, name: "Sub A1", size: 4, children: [], depth: 2)
        let subA2 = TestNode(identifier: UUID().uuidString, name: "Sub A2", size: 4, children: [], depth: 2)
        let a = TestNode(identifier: UUID().uuidString, name: "Topic A", size: 8, children: [subA1, subA2], depth: 1)
        
        let subB1 = TestNode(identifier: UUID().uuidString, name: "Sub B1", size: 3, children: [], depth: 2)
        let subB2 = TestNode(identifier: UUID().uuidString, name: "Sub B2", size: 3, children: [], depth: 2)
        let subB3 = TestNode(identifier: UUID().uuidString, name: "Sub B3", size: 3, children: [], depth: 2)
        let b = TestNode(identifier: UUID().uuidString, name: "Topic B", size: 9, children: [subB1, subB2, subB3], depth: 1)

        let subC1 = TestNode(identifier: UUID().uuidString, name: "Sub C1", size: 4, children: [], depth: 2)
        let subC2 = TestNode(identifier: UUID().uuidString, name: "Sub C2", size: 4, children: [], depth: 2)
        let c = TestNode(identifier: UUID().uuidString, name: "Topic C", size: 8, children: [subC1, subC2], depth: 1)

        let node = TestNode(identifier: UUID().uuidString, name: "TOPICS", size: 25, children: [a, b, c])
        
        func assignParents(n: TestNode) -> Int {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.autoresizingMask = [.width, .height]
        view.addSubview(chartView)
        d3Test()
    }
    
    func d3Test() {
        let partition = TreePartition(root: ViewController.nodeData, size: 250)
        print(partition.nodes.count)
        for i in 0...30 {
            
            let logg = OSLog(
                subsystem: "org.cindori.ChartDemo",
                category: "ChartBuilding"
            )
            let signpostID = OSSignpostID(log: logg)
            os_signpost(.begin,
                log: logg,
                name: "Calculate layout changes",
                signpostID: signpostID,
                "%{public}s",
                "TreePartition"
            )

            /// Calculate layout changes
            let layoutChanges = partition.calculateLayoutChanges()
            
            os_signpost(.end,
                log: logg,
                name: "Calculate layout changes",
                signpostID: signpostID,
                "%{public}s",
                "TreePartition"
            )
            
            
            for node in partition.nodes {
                os_signpost(.begin,
                    log: logg,
                    name: "Arc setup",
                    signpostID: signpostID,
                    "%{public}s",
                    "Node Setup"
                )
                
                /// Perform arc setup
                let arc = ArcLayer()
                if node.depth == 0 {
                    arc.fillColor = NSColor.clear.cgColor
                } else {
                    arc.fillColor = NSColor.random().cgColor
                }
                arc.strokeColor = NSColor.windowBackgroundColor.cgColor
                arc.name = node.name
                if let newLayout = layoutChanges[node] {
                    arc.update(newLayout)
                }
                
                os_signpost(.end,
                    log: logg,
                    name: "Arc setup",
                    signpostID: signpostID,
                    "%{public}s",
                    "Node Setup"
                )
                
                os_signpost(.begin,
                    log: logg,
                    name: "Add Arc to Chart",
                    signpostID: signpostID,
                    "%{public}s",
                    "Add Arc"
                )
                
                chartView.addArc(arc)
                
                os_signpost(.end,
                    log: logg,
                    name: "Add Arc to Chart",
                    signpostID: signpostID,
                    "%{public}s",
                    "Node Setup"
                )
            }
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
