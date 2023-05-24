//
//  ArrowView.swift
//  
//
//  Created by Nail Sharipov on 22.05.2023.
//

import SwiftUI
import simd

public struct Arrow: Identifiable {
    
    public static let empty = Arrow(id: 0, start: .zero, end: .zero)
    
    public let id: Int
    public let start: CGPoint
    public let end: CGPoint
    public let arrowColor: Color
    public let tailColor: Color
    public let lineWidth: CGFloat
    public let angle: Float
    
    public init(
        id: Int,
        start: CGPoint,
        end: CGPoint,
        arrowColor: Color = .gray,
        tailColor: Color = .gray,
        lineWidth: CGFloat = 2,
        angle: Float = 20
    ) {
        self.id = id
        self.start = start
        self.end = end
        self.arrowColor = arrowColor
        self.tailColor = tailColor
        self.lineWidth = lineWidth
        self.angle = angle
    }

}

public struct ArrowView: View {

    public init(arrow: Arrow) {
        self.arrow = arrow
    }
    
    public let arrow: Arrow
    
    public var body: some View {
        ZStack() {
            Path { path in
                path.move(to: arrow.end)
                path.addLine(to: arrow.start)
            }.strokedPath(.init(lineWidth: arrow.lineWidth)).foregroundColor(arrow.tailColor)
            Path { path in
                path.addLines(arrow.endPoints)
            }.strokedPath(.init(lineWidth: arrow.lineWidth)).foregroundColor(arrow.arrowColor)
        }
    }
    
}


private extension Arrow {
    
    var endPoints: [CGPoint] {
        let dir = end - start
        let v = 0.7 * simd_float2(Float(dir.x), Float(dir.y))
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
