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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.autoresizingMask = [.width, .height]
        view.addSubview(chartView)
        chartView.d3Test()
    }


}

