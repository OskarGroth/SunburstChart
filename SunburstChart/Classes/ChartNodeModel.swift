//
//  ChartNodeModel.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

/// A model for a Chart Node Model used inside a section.
///
/// - SeeAlso: `ChartSection`
public struct ChartNodeModel: Identifiable {
    
    public typealias NodeConfigurator = (SBChartView, ChartNode) -> Void
    
    /// The data for this cell.
    public var data: AnyEquatable?
    
    /// A function that configures the node with data when it is dequeued.
    public var nodeConfigurator: NodeConfigurator?
    
    /// A string that uniquely identifies this cell within the table view.
    public var identifier: String
    
    /// The identifier for the chart node to reuse for this model.
    public var nodeReuseIdentifier: String
    
    /// :nodoc:
    public var hashValue: Int {
        return nodeReuseIdentifier.hashValue
    }
    
    /// A plain initializer to be used with a standard `ChartNodeModel`.
    ///
    /// - Parameters:
    ///   - identifier: A string that uniquely identifies this cell model within the table view.
    ///   - nodeReuseIdentifier: The identifier for the table view cell to reuse for this model.
    ///   - data: The data for this node.
    ///   - nodeConfigurator: A function that configures the table view cell with data when it is dequeued.
    public init(
        identifier: String,
        nodeReuseIdentifier: String,
        data: AnyEquatable? = nil,
        nodeConfigurator: NodeConfigurator? = nil) {
        
        self.identifier = identifier
        self.nodeReuseIdentifier = nodeReuseIdentifier
        self.data = data
        self.nodeConfigurator = nodeConfigurator
    }
    
    /// :nodoc:
    public static func == (lhs: ChartNodeModel, rhs: ChartNodeModel) -> Bool {
        return lhs.identifier == rhs.identifier
            && lhs.nodeReuseIdentifier == rhs.nodeReuseIdentifier
    }

}
