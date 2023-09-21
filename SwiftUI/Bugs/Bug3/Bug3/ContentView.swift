//
//  ContentView.swift
//  Bug3
//
//  Created by Maksim Gaiduk on 21/09/2023.
//

import SwiftUI

struct ArcPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        let startPoint = path.currentPoint!
        let to = CGPoint(x: 128, y: 128)
        let radius = 128.0
        let center = CGPoint(x: 128, y: 0)
        let angle1 = Angle(degrees: 90)
        let angle2 = Angle(degrees: 180)
        path.addArc(center: center, radius: radius, startAngle: angle1, endAngle: angle2, clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: 128))
        path.closeSubpath()
        return path
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ArcPath()
                .fill(.black)
        }
        .frame(width: 256, height: 256)
        .padding()
    }
}

#Preview {
    ContentView()
}
