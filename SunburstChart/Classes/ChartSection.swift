//
//  ChartSection.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation
import DifferenceKit

/// A model representing a section in a `SunburstChart`.
///
/// - SeeAlso: `ChartNodeModel`
public struct ChartSection: IdentifiableSection, Equatable {
    
    /// A string that uniquely identifies this section within the table view.
    public var identifier: String
    
    /// The node models for this section.
    public var items: [ChartNodeModel]
    
    /// The designated initializer.
    ///
    /// - Parameters:
    ///   - identifier: A string that uniquely identifies this section within the table view.
    ///   - nodes: The node models for this section.
    public init(identifier: String, nodes: [ChartNodeModel]) {
        self.identifier = identifier
        self.items = nodes
    }
    
    public init<C>(source: ChartSection, elements: C) where C: Collection, C.Element == ChartNodeModel {
        self = source
        self.items = Array(elements)
    }
    
    /// :nodoc:
    public static func == (lhs: ChartSection, rhs: ChartSection) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}

extension ChartSection: Hashable {
    /// :nodoc:
    public var hashValue: Int {
        return identifier.hashValue
    }
}
