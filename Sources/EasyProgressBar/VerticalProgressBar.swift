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
public struct VerticalProgressBar: View {
    @Binding var progress: CGFloat // 0.0 to 1.0
    var barColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.2)
    var lineWidth: CGFloat = 8
    var lineCap: CGLineCap = .round
    var animationType: ProgressBarAnimationType = .simple
    var animationDuration: Double = 1.0
    var foregroundGradient: [Color]? = nil

    @State private var animatedProgress: CGFloat = 0.0
    @State private var isForward: Bool = true

    public init(progress: Binding<CGFloat>,
                barColor: Color = .blue,
                backgroundColor: Color = .gray.opacity(0.2),
                lineWidth: CGFloat = 8,
                lineCap: CGLineCap = .round,
                animationType: ProgressBarAnimationType = .simple,
                animationDuration: Double = 1.0,
                foregroundGradient: [Color]? = nil) {
        self._progress = progress
        self.barColor = barColor
        self.backgroundColor = backgroundColor
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.animationType = animationType
        self.animationDuration = animationDuration
        self.foregroundGradient = foregroundGradient
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(backgroundColor)
                    .frame(width: lineWidth, height: geometry.size.height)
                if let gradient = foregroundGradient {
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .bottom, endPoint: .top))
                        .frame(width: lineWidth, height: geometry.size.height * animatedProgress)
                } else {
                    Capsule()
                        .fill(barColor)
                        .frame(width: lineWidth, height: geometry.size.height * animatedProgress)
                }
            }
            .frame(width: lineWidth)
            .onAppear { setupAnimation() }
            .onChange(of: progress) { _ in setupAnimation() }
        }
    }

    private func setupAnimation() {
        switch animationType {
        case .none:
            animatedProgress = progress
        case .simple:
            withAnimation(.easeInOut(duration: animationDuration)) {
                animatedProgress = progress
            }
        case .forwardBackward:
            animateForwardBackward()
        }
    }

    private func animateForwardBackward() {
        let target: CGFloat = isForward ? 1.0 : 0.0
        withAnimation(.linear(duration: animationDuration)) {
            animatedProgress = target
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            isForward.toggle()
            animateForwardBackward()
        }
    }
}

@available(iOS 14.0, *)
public extension VerticalProgressBar {
    func barColor(_ color: Color) -> Self {
        var copy = self
        copy.barColor = color
        return copy
    }
    func backgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    func lineWidth(_ width: CGFloat) -> Self {
        var copy = self
        copy.lineWidth = width
        return copy
    }
    func lineCap(_ cap: CGLineCap) -> Self {
        var copy = self
        copy.lineCap = cap
        return copy
    }
    func animationType(_ type: ProgressBarAnimationType) -> Self {
        var copy = self
        copy.animationType = type
        return copy
    }
    func animationDuration(_ duration: Double) -> Self {
        var copy = self
        copy.animationDuration = duration
        return copy
    }
    func foregroundGradient(_ colors: [Color]) -> Self {
        var copy = self
        copy.foregroundGradient = colors
        return copy
    }
    func barShadow(color: Color = .black, radius: CGFloat = 4, x: CGFloat = 0, y: CGFloat = 2) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y)
    }
    func barGlow(color: Color = .blue, radius: CGFloat = 10) -> some View {
        self.shadow(color: color, radius: radius)
    }
}
#endif
