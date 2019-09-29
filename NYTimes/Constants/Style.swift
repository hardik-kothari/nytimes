//
//  Style.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit

// MARK: - Font
struct Font {
    // Font type name
    static let black = "HelveticaNeue-CondensedBlack"
    static let bold = "HelveticaNeue-Bold"
    static let regular = "HelveticaNeue"
    static let light = "HelveticaNeue-Light"
    static let medium = "HelveticaNeue-Medium"
    
    // Font size
    enum Size: CGFloat {
        case extraSmall = 12
        case small = 14
        case medium = 16
        case regular = 18
        case large = 20
        case extraLarge = 28
    }
}

// MARK: - Padding
public struct Padding {
    enum Margin: CGFloat {
        case extraSmall = 8
        case small = 16
        case medium = 24
        case regular = 32
        case large = 40
        case extraLarge = 80
    }
}
