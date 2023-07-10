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
    
    public init(position: CGPoint, radius: CGFloat, color: Color) {
        self.position = position
        self.radius = radius
        self.color = color
    }
    
    public var body: some View {
        Circle()
            .size(width: 2 * radius, height: 2 * radius)
            .offset(CGPoint(x: position.x - radius, y: position.y - radius))
            .foregroundColor(color)
    }

}

