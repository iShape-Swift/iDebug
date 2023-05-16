//
//  CGFloat+FixFloat.swift
//  iDebug
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics
import iFixFloat

public extension Float {
    var gradToRad: Float {
        (self / 180) * .pi
    }
}

public extension CGFloat {
    
    var fix: FixFloat {
        Float(self).fix
    }
    
}

public extension FixFloat {
    
    var cgFloat: CGFloat {
        CGFloat(self.double)
    }
    
}
