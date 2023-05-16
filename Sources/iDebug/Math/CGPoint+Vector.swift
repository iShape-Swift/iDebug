//
//  CGPoint+Vector.swift
//  iDebug
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics
import iFixFloat

public extension CGPoint {
    
    var length: CGFloat {
        (x * x + y * y).squareRoot()
    }
    
    var magnitude: CGFloat {
        x * x + y * y
    }
    
    var normalize: CGPoint {
        let l = self.length
        return CGPoint(x: x / l, y: y / l)
    }
    
    var fixVec: FixVec {
        FixVec(x.fix, y.fix)
    }
    
    func round(scale: CGFloat) -> CGPoint {
        let rx = (x / scale).rounded() * scale
        let ry = (y / scale).rounded() * scale
        return CGPoint(x: rx, y: ry)
    }

}

public func +(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func -(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func *(left: CGFloat, right: CGPoint) -> CGPoint {
    CGPoint(x: left * right.x, y: left * right.y)
}

public func /(left: CGPoint, right: CGFloat) -> CGPoint {
    CGPoint(x: left.x / right, y: left.y / right)
}

public extension FixVec {
    
    var point: CGPoint {
        CGPoint(x: x.cgFloat, y: y.cgFloat)
    }
    
}
