//
//  ViewController.swift
//  ChartDemo
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Cocoa
import SunburstChart

class ViewController: NSViewController {
    
    lazy var chartView = SBChartView(frame: view.bounds)
    lazy var dataSource = ChartDataSource(sections: sections())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.autoresizingMask = [.width, .height]
        view.addSubview(chartView)
        dataSource.setup(with: chartView)
    }
    
    let testSection: ChartSection = {
        return ChartSection(identifier: "Test", nodes: [
            ChartNodeModel(identifier: "Node 1", nodeReuseIdentifier: "Node 1", data: nil, nodeConfigurator: nil)])
    }()

    func sections() -> [ChartSection] {
        return [testSection]
    }


}

