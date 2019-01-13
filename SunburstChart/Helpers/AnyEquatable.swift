//
//  AnyEquatable.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

/// A type erasing equality protocol. Works like the good ol' Objective-C `isEqual`.
/// Hashable types just need to add the protocol to their interface without writing any implementation.
/// Example: `extension String: AnyEquatable {}`
public protocol AnyEquatable {
    
    /// :nodoc:
    func isEqual(to thing: Any?) -> Bool
    
    /// :nodoc:
    var hashValue: Int { get }
}

extension Equatable {
    
    /// :nodoc:
    public func isEqual(to thing: Any?) -> Bool {
        if let thing = thing as? Self {
            return self == thing
        }
        return false
    }
    
}

/// :nodoc:
public func == (lhs: AnyEquatable?, rhs: AnyEquatable?) -> Bool {
    if let lhs = lhs {
        return lhs.isEqual(to: rhs)
    } else if rhs != nil {
        return false
    } else {
        return true
    }
}

public func == (lhs: [String: AnyEquatable], rhs: [String: AnyEquatable]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (key, value) in lhs {
        guard let rValue = rhs[key], rValue == value else { return false }
    }
    return true
}

public func != (lhs: [String: AnyEquatable], rhs: [String: AnyEquatable]) -> Bool {
    return !(lhs == rhs)
}

extension String: AnyEquatable {}
extension Bool: AnyEquatable {}
extension Float: AnyEquatable {}
extension Double: AnyEquatable {}
extension CGFloat: AnyEquatable {}
extension Data: AnyEquatable {}
extension Date: AnyEquatable {}
