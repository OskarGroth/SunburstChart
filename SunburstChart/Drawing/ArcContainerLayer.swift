//
//  ArcContainerLayer.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-17.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

class ArcContainerLayer: CALayer {
    
    var scale: CGFloat {
        return min(bounds.width, bounds.height)/ArcChartView.defaultSize
    }
        
    override func resizeSublayers(withOldSize size: CGSize) {
        super.resizeSublayers(withOldSize: size)
        let position = ArcChartView.defaultSize/2
        let updatedScale = CATransform3DMakeScale(scale, scale, 1.0)
        let translate = CATransform3DMakeTranslation(position, position, 1.0)
        sublayers?.forEach({ $0.transform = CATransform3DConcat(translate, updatedScale) })
    }
    
}
