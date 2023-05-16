//
//  CGSize+Compare.swift
//  iDebug
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics

public extension CGSize {
    
    func isIntSame(_ size: CGSize) -> Bool {
        Int(size.width) == Int(width) && Int(size.height) == Int(height)
    }
    
}
