//
//  ContourEditor.swift
//  iDebug
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

public final class ContourEditor: ObservableObject, Identifiable {

    @Published
    public var matrix: Matrix = .empty
    
    public var onUpdate: (([CGPoint]) -> ())?

    private (set) var color: Color
    private (set) var stroke: CGFloat = 2
    private (set) var showArrows: Bool = true

    private let showIndex: Bool
    private let indexOffset: Int
    public private (set) var points: [CGPoint] = []
    private (set) var screenPoints: [CGPoint] = []
    private var selectedId = -1
    private var selectedStart: CGPoint = .zero
    
    public var data: (dots: [EditorDot], arrows: [Arrow]) {
        guard !points.isEmpty else {
            return ([], [])
        }
        
        screenPoints = matrix.screen(worldPoints: points)
        var dots = [EditorDot](repeating: .empty, count: screenPoints.count)
        var arrows = [Arrow](repeating: .empty, count: screenPoints.count)
        let radius: CGFloat = 3
        let touchRadius: CGFloat = 22
        var p0 = screenPoints[screenPoints.count - 1]
        for i in 0..<screenPoints.count {
            let p1 = screenPoints[i]
            let center = p1 - CGPoint(x: radius, y: radius)
            let touchCenter = p1 - CGPoint(x: touchRadius, y: touchRadius)
            let touchColor: Color = selectedId == i ? .black.opacity(0.15) : .black.opacity(0.05)
            
            let title: String? = showIndex ? String(i + indexOffset) : nil
            
            dots[i] = EditorDot(id: i, center: center, touchCenter: touchCenter, radius: radius, touchRadius: touchRadius, color: .gray, touchColor: touchColor, title: title)
            
            let m = 0.5 * (p0 + p1)
            let n = (p1 - p0).normalize
            
            arrows[i] = Arrow(id: i, start: m - 4 * n, end: m + 4 * n, arrowColor: color, tailColor: color, lineWidth: stroke)
            
            p0 = p1
        }

        return (dots, arrows)
    }
    
    private let scale: CGFloat
    
    public init(scale: CGFloat = 1, indexOffset: Int = 0, showIndex: Bool = false, color: Color = .gray, showArrows: Bool = true) {
        self.color = color
        self.scale = scale
        self.showIndex = showIndex
        self.indexOffset = indexOffset
        self.showArrows = showArrows
    }
    
    public func set(points: [CGPoint]) {
        self.points = points
        self.objectWillChange.send()
    }
    
    public func makeView(matrix: Matrix) -> ContourEditorView {
        if !self.matrix.screenSize.isIntSame(matrix.screenSize) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.matrix = matrix
                self.objectWillChange.send()
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
            screenPoints = matrix.screen(worldPoints: points)
            onUpdate?(points)
            self.objectWillChange.send()
        }
    }
    
    public func set(stroke: CGFloat, color: Color) {
        self.stroke = stroke
        self.color = color
        self.objectWillChange.send()
    }
}
