//
//  ContourEditor.swift
//  iDebug
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

public final class ContourEditor: ObservableObject, Identifiable {

    private var matrix: Matrix = .empty
    
    public var onUpdate: (([CGPoint]) -> ())?

    private (set) var points: [CGPoint] = []
    
    
    private (set) var screenPoints: [CGPoint] = []
    private var selectedId = -1
    private var selectedStart: CGPoint = .zero
    
    public var dots: [EditorDot] {
        screenPoints = matrix.screen(wordPoints: points)
        var buffer = [EditorDot](repeating: .empty, count: screenPoints.count)
        let radius: CGFloat = 3
        let touchRadius: CGFloat = 22
        for i in 0..<screenPoints.count {
            let center = screenPoints[i] - CGPoint(x: radius, y: radius)
            let touchCenter = screenPoints[i] - CGPoint(x: touchRadius, y: touchRadius)
            let touchColor: Color = selectedId == i ? .black.opacity(0.15) : .black.opacity(0.05)
            
            buffer[i] = EditorDot(id: i, center: center, touchCenter: touchCenter, radius: radius, touchRadius: touchRadius, color: .gray, touchColor: touchColor, title: nil)
        }

        return buffer
    }
    
    private let scale: CGFloat
    
    public init(scale: CGFloat = 1) {
        self.scale = scale
    }
    
    public func set(points: [CGPoint]) {
        self.points = points
        self.objectWillChange.send()
    }
    
    public func makeView(matrix: Matrix) -> ContourEditorView {
        if !self.matrix.screenSize.isIntSame(matrix.screenSize) {
            self.matrix = matrix
            DispatchQueue.main.async { [weak self] in
                self?.objectWillChange.send()
            }
        }
        return ContourEditorView(editor: self)
    }
    
    public func onDrag(id: Int, move: CGSize) {
        if selectedId == -1 {
            selectedId = id
            selectedStart = points[id]
        }
        update(id: id, move: move)
    }

    public func onEnd(id: Int, move: CGSize) {
        selectedId = -1
        update(id: id, move: move)
    }
    
    private func update(id: Int, move: CGSize) {
        let newPoint = selectedStart + matrix.world(screenVector: CGPoint(x: move.width, y: move.height))
        if newPoint != points[id] || selectedId == -1 {
            points[id] = newPoint.round(scale: scale)
            screenPoints = matrix.screen(wordPoints: points)
            onUpdate?(points)
            self.objectWillChange.send()
        }
    }
}
