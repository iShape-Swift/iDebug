//
//  CircleView.swift
//  
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI

public struct CircleView: View {
    
    public let position: CGPoint
    public let radius: CGFloat
    public let color: Color
    public let stroke: CGFloat?
    
    public init(position: CGPoint, radius: CGFloat, color: Color, stroke: CGFloat? = nil) {
        self.position = position
        self.radius = radius
        self.color = color
        self.stroke = stroke
    }
    
    public var body: some View {
        if let stroke = stroke {
            Circle()
                .size(width: 2 * radius, height: 2 * radius)
                .offset(CGPoint(x: position.x - radius, y: position.y - radius))
                .stroke(style: .init(lineWidth: stroke))
                .foregroundColor(color)
        } else {
            Circle()
                .size(width: 2 * radius, height: 2 * radius)
                .offset(CGPoint(x: position.x - radius, y: position.y - radius))
                .foregroundColor(color)
        }
    }

}

