//
//  NSColor+LighterDarker.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-14.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public extension NSColor {
    
    /// A lighter version of the reciever.
    var lighterColor: NSColor {
        return color(withBrightness: 1.33)
    }
    
    /// A darker version of the reciever.
    var darkerColor: NSColor {
        return color(withBrightness: 0.75)
    }
    
    /// Creates and returns a color object with modified brightness.
    ///
    /// - Parameter percent: The brightness change defined as a float where values < 1 results in a darker color and values > 1 returns in a lighter color.
    ///
    /// - Returns: The new UIColor object
    func color(withBrightness percent: CGFloat) -> NSColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        let brightness: CGFloat = b*percent
        return NSColor(hue: h, saturation: s, brightness: brightness, alpha: a)
    }
    
}
