//
//  EditorDot.swift
//  iDebug
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

public struct EditorDot: Identifiable {
    
    public static let empty = EditorDot(id: 0, center: .zero, touchCenter: .zero, radius: .zero, touchRadius: .zero, color: .gray, touchColor: .white, title: nil)
    
    public let id: Int
    public let center: CGPoint
    public let touchCenter: CGPoint
    public let radius: CGFloat
    public let touchRadius: CGFloat
    public let color: Color
    public let touchColor: Color
    public let title: String?
}
