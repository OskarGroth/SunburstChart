//
//  SBChartView.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation
import SpriteKit

public protocol ChartViewDataSource {
    
    func numberOfSections(in: SBChartView) -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func chartView(_ chartView: SBChartView, nodeForRowAt indexPath: IndexPath) -> ChartNode

}

public class SBChartView: SKView {
    
    public var dataSource: ChartViewDataSource?
    
    public func reloadData() {
        print("Chart view reloaded data")
        print("Datasource has \(dataSource?.numberOfSections(in: self)) sections")
    }

}
