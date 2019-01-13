//
//  Identifiable.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-10.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation
import DifferenceKit

/// Signifies a `Hashable`, `Equatable` object with a designated identifier.
public protocol Identifiable: Hashable, Differentiable {

    /// The identifier type.
    associatedtype Identifier: Hashable

    /// The identifier. This should uniquely indentify this object.
    var identifier: Identifier { get }
}

extension Identifiable {

    public var differenceIdentifier: Identifier {
        return identifier
    }

}

/// An identifiable section.
public protocol IdentifiableSection: Identifiable, DifferentiableSection {

    /// The item type.
    associatedtype Item: Identifiable

    /// The items contained within the section.
    var items: [Item] { get set }
}

extension IdentifiableSection {

    public var differenceIdentifier: Identifier {
        return identifier
    }

    public var elements: [Item] {
        return items
    }

}
