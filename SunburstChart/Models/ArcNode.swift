//
//  ArcNode.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-18.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public protocol ArcNode: Comparable, Hashable, AnyEquatable {
    
    var name: String { get set }
    var size: CGFloat { get set }
    var children: [Self] { get set }
    var parent: Self? { get set }
    var height: Int { get set }
    var depth: Int { get set }
    var layout: ArcLayout { get set }
    var style: ArcStyle? { get set }
    
}
