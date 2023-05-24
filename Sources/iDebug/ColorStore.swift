//
//  ColorStore.swift
//  
//
//  Created by Nail Sharipov on 19.05.2023.
//

import SwiftUI

private struct ColorStore {
    
    static var colors: [Color] = [
        .orange,
        .purple,
        .pink,
        .indigo,
        .mint,
        .brown,
        .teal,
        .yellow,
        .cyan,
        .red,
        .green,
        .blue
    
    ]
}

public extension Color {
    
    init(index: Int) {
        let n = ColorStore.colors.count
        let i = index % n
        self = ColorStore.colors[i]
    }
    
}
