//
//  VectorView.swift
//  
//
//  Created by Nail Sharipov on 11.07.2023.
//

import SwiftUI
import simd

public struct Vector: Identifiable {
    
    public static let empty = Vector(id: 0, start: .zero, end: .zero)
    
    public let id: Int
    public let start: CGPoint
    public let end: CGPoint
    public let arrowLength: CGFloat
    public let arrowColor: Color
    public let color: Color
    public let lineWidth: CGFloat
    public let angle: Float
    
    public init(
        id: Int,
        start: CGPoint,
        end: CGPoint,
        color: Color = .gray,
        lineWidth: CGFloat = 2,
        arrowLength: CGFloat = 10,
        arrowColor: Color = .gray,
        angle: Float = 20
    ) {
        self.id = id
        self.start = start
        self.end = end
        self.color = color
        self.lineWidth = lineWidth
        self.arrowLength = arrowLength
        self.arrowColor = arrowColor
        self.angle = angle
    }

}

public struct VectorView: View {

    public init(vector: Vector) {
        self.vector = vector
    }
    
    public let vector: Vector
    
    public var body: some View {
        ZStack() {
            Path { path in
                path.move(to: vector.end)
                path.addLine(to: vector.start)
            }.strokedPath(.init(lineWidth: vector.lineWidth)).foregroundColor(vector.color)
            Path { path in
                path.addLines(vector.endPoints)
            }.strokedPath(.init(lineWidth: vector.lineWidth)).foregroundColor(vector.arrowColor)
        }
    }
    
}


private extension Vector {
    
    var endPoints: [CGPoint] {
        let dir = (end - start).normalize
        let v = Float(arrowLength) * simd_float2(Float(dir.x), Float(dir.y))
        let rad = angle.gradToRad
        let cs = cos(rad)
        let sn = sin(rad)

        let rot0 = matrix_float2x2(simd_float2(cs, sn), simd_float2(-sn, cs))
        let rot1 = matrix_float2x2(simd_float2(cs, -sn), simd_float2(sn, cs))
        
        let aw0 = matrix_multiply(rot0, v)
        let aw1 = matrix_multiply(rot1, v)
        let a0 = CGPoint(x: CGFloat(aw0.x), y: CGFloat(aw0.y))
        let a1 = CGPoint(x: CGFloat(aw1.x), y: CGFloat(aw1.y))
       
        let p0 = end - a0
        let p1 = end
        let p2 = end - a1

        return [p0, p1, p2]
    }
    
}
