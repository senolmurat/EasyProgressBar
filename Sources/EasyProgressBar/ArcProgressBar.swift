//
//  HorizontalProgressBar.swift
//  EasyProgressBarSwiftUI
//
// Copyright (c) 2024 Murat Şenol
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14.0, *)
struct ArcProgressBar: View {
    @Binding var progress: CGFloat // 0.0 to 1.0
    var barColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.2)
    var lineWidth: CGFloat = 8
    var lineCap: CGLineCap = .round
    var animationType: EasyProgressBarAnimationType = .simple(duration: 1)
    var startAngle: Angle = .degrees(180)
    var endAngle: Angle = .degrees(360)
    var foregroundGradient: [Color]? = nil

    @State private var animatedProgress: CGFloat = 0.0
    @State private var isForward: Bool = true

    public init(progress: Binding<CGFloat>,
                barColor: Color = .blue,
                backgroundColor: Color = .gray.opacity(0.2),
                lineWidth: CGFloat = 8,
                lineCap: CGLineCap = .round,
                animationType: EasyProgressBarAnimationType = .simple(duration: 1),
                startAngle: Angle = .degrees(180),
                endAngle: Angle = .degrees(360),
                foregroundGradient: [Color]? = nil) {
        self._progress = progress
        self.barColor = barColor
        self.backgroundColor = backgroundColor
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.animationType = animationType
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.foregroundGradient = foregroundGradient
    }

    public var body: some View {
        ZStack {
            ArcShape(startAngle: startAngle, endAngle: endAngle, progress: 1.0)
                .stroke(backgroundColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
            if let gradient = foregroundGradient {
                ArcShape(startAngle: startAngle, endAngle: endAngle, progress: animatedProgress)
                    .stroke(AngularGradient(gradient: Gradient(colors: gradient), center: .center), style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
            } else {
                ArcShape(startAngle: startAngle, endAngle: endAngle, progress: animatedProgress)
                    .stroke(barColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
            }
        }
        .onAppear { setupAnimation() }
        .onChange(of: progress) { _ in setupAnimation() }
    }

    private func setupAnimation() {
        switch animationType {
        case .none:
            animatedProgress = progress
        case let .simple(duration):
            withAnimation(.easeInOut(duration: duration)) {
                animatedProgress = progress
            }
        case let .forwardBackward(duration):
            animateForwardBackward(duration)
        }
    }

    private func animateForwardBackward(_ duration: Double) {
        let target: CGFloat = isForward ? 1.0 : 0.0
        withAnimation(.linear(duration: duration)) {
            animatedProgress = target
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            isForward.toggle()
            animateForwardBackward(duration)
        }
    }
}

// ArcShape for drawing the arc
@available(iOS 14.0, *)
struct ArcShape: Shape, Animatable {
    var startAngle: Angle
    var endAngle: Angle
    var progress: CGFloat // 0.0 to 1.0
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let totalAngle = endAngle.radians - startAngle.radians
        let end = startAngle.radians + totalAngle * Double(progress)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: Angle(radians: startAngle.radians),
                    endAngle: Angle(radians: end),
                    clockwise: false)
        return path
    }
}
#endif
