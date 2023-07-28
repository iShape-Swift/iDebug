//
//  TextDot.swift
//  
//
//  Created by Nail Sharipov on 13.07.2023.
//

import SwiftUI


public struct TextDot: Identifiable {
    
    public let id: Int
    public let center: CGPoint
    public let radius: CGFloat
    public let color: Color
    public let textColor: Color
    public let font: Font
    public let text: String?
    
    
    public init(id: Int, center: CGPoint, radius: CGFloat, color: Color, textColor: Color = .black, font: Font = .body, text: String? = nil) {
        self.id = id
        self.center = center
        self.radius = radius
        self.color = color
        self.textColor = textColor
        self.font = font
        self.text = text
    }
    
}

public struct TextDotView: View {
    
    public let dot: TextDot
    
    public init(dot: TextDot) {
        self.dot = dot
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .size(width: 2 * dot.radius, height: 2 * dot.radius)
                .offset(CGPoint(x: dot.center.x - dot.radius, y: dot.center.y - dot.radius))
                .foregroundColor(dot.color)
            if let text = dot.text {
                Text(text)
                    .font(dot.font)
                    .position(dot.center + CGPoint(x: -2, y: -12))
                    .foregroundColor(dot.textColor)
            }
        }
    }

}
