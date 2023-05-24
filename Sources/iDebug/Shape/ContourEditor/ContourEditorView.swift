//
//  ContourEditorView.swift
//  iDebug
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

public struct ContourEditorView: View {

    @ObservedObject
    public var editor: ContourEditor
    
    public var body: some View {
        let data = editor.data
        return ZStack() {
            Path { path in
                path.addLines(editor.screenPoints)
                path.closeSubpath()
            }.strokedPath(.init(lineWidth: editor.stroke)).foregroundColor(editor.color)
            ForEach(data.dots) { dot in
                Circle()
                    .size(width: 2 * dot.radius, height: 2 * dot.radius)
                    .offset(dot.center)
                    .foregroundColor(dot.color)
                if let title = dot.title {
                    Text(title).font(.title3).foregroundColor(editor.color).position(dot.center + CGPoint(x: 8, y: -8))
                }
            }
            ForEach(data.arrows) { arrow in
                ArrowView(arrow: arrow)
            }

            ForEach(data.dots) { dot in
                Circle()
                    .size(width: 2 * dot.touchRadius, height: 2 * dot.touchRadius)
                    .offset(dot.touchCenter)
                    .foregroundColor(dot.touchColor)
                    .gesture(
                        DragGesture()
                            .onChanged { data in
                                editor.onDrag(id: dot.id, move: data.translation)
                            }
                            .onEnded { data in
                                editor.onEnd(id: dot.id, move: data.translation)
                            }
                    )
            }

        }
    }
    
}
