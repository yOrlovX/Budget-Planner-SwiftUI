//
//  SemiCircleView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 07.06.2022.
//

import SwiftUI

struct SemiCircleView: View {
    var body: some View {
      var style = StrokeStyle()
      style.lineCap = .round
              style.lineWidth = 20
              return Semicircle()
                  .stroke(Color.pink, style: style)
    }
}

struct Semicircle: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 3
      let startAngle = Angle.degrees(50)
        let endAngle = Angle(degrees: 125)
        let clockwise = true
        return Path { p in
            p.addArc(center: center,
                     radius: radius,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: clockwise)
        }
    }
}

struct SemiCircleView_Previews: PreviewProvider {
    static var previews: some View {
        SemiCircleView()
    }
}

