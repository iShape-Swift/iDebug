//
//  Matrix.swift
//  iDebug
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics
import simd

public struct Matrix {
    
    public static let empty = Matrix(screenSize: .zero, toWorld: simd_float3x3.init(0), toScreen: simd_float3x3.init(0))
    
    public let screenSize: CGSize
    public let inverseY: Bool
    public var toWorld: simd_float3x3
    public var toScreen: simd_float3x3
    public var scale: CGFloat { CGFloat(toScreen.columns.0.x) }
    
    public var isZero: Bool { screenSize == .zero }
    
    public init(screenSize: CGSize, toWorld: simd_float3x3, toScreen: simd_float3x3) {
        self.screenSize = screenSize
        self.toWorld = toWorld
        self.toScreen = toScreen
        self.inverseY = false
    }
    
    public init(screenSize: CGSize, scale: Float, inverseY: Bool) {
        self.screenSize = screenSize
        self.inverseY = inverseY
                
        let sx = scale
        let sy = inverseY ? -scale : scale
        
        let dx = Float(0.5 * Float(screenSize.width))
        let dy = Float(0.5 * Float(screenSize.height))
        
        toScreen = simd_float3x3([
            simd_float3(sx, 0, 0),
            simd_float3(0, sy, 0),
            simd_float3(dx, dy, 1)
        ])
        
        toWorld = toScreen.inverse
    }
    
    @inline(__always)
    public mutating func update(scale: Float) {
        let sx = scale
        let sy = inverseY ? -scale : scale
        
        let dx = Float(0.5 * Float(screenSize.width))
        let dy = Float(0.5 * Float(screenSize.height))
        
        toScreen = simd_float3x3([
            simd_float3(sx, 0, 0),
            simd_float3(0, sy, 0),
            simd_float3(dx, dy, 1)
        ])
        
        toWorld = toScreen.inverse
    }

    
    @inline(__always)
    public func screen(world l: CGFloat) -> CGFloat {
        CGFloat(toScreen.columns.0.x) * l
    }
    
    @inline(__always)
    public func screen(worldPoint p: CGPoint) -> CGPoint {
        let v = simd_float3(Float(p.x), Float(p.y), 1)
        let r = toScreen * v
        return CGPoint(x: CGFloat(r.x), y: CGFloat(r.y))
    }
    
    @inline(__always)
    public func screen(worldPoints points: [CGPoint]) -> [CGPoint] {
        var result = [CGPoint](repeating: .zero, count: points.count)
        for i in 0..<points.count {
            result[i] = screen(worldPoint: points[i])
        }
        return result
    }
    
    @inline(__always)
    public func world(screenPoint p: CGPoint) -> CGPoint {
        let v = simd_float3(Float(p.x), Float(p.y), 1)
        let r = toWorld * v
        return CGPoint(x: CGFloat(r.x), y: CGFloat(r.y))
    }

    @inline(__always)
    public func world(screenVector s: CGPoint) -> CGPoint {
        let v = simd_float3(Float(s.x), Float(s.y), 0)
        let r = toWorld * v
        return CGPoint(x: CGFloat(r.x), y: CGFloat(r.y))
    }
    
    @inline(__always)
    public func world(screenPoints points: [CGPoint]) -> [CGPoint] {
        var result = [CGPoint](repeating: .zero, count: points.count)
        for i in 0..<points.count {
            result[i] = world(screenPoint: points[i])
        }
        return result
    }
}
