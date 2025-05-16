//
// EasyProgressBar.swift
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

#if canImport(UIKit)
import UIKit
// implementation here...

@objc public enum ProgressBarAnimationTypeUIKit: Int {
    case none
    case simple
    case forwardBackward
}

@available(iOS 13.0, *)
@IBDesignable
public class HorizontalProgressView: UIView {
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet { setNeedsDisplay(); animateIfNeeded() }
    }
    @IBInspectable public var barColor: UIColor = .systemBlue { didSet { setNeedsDisplay() } }
    @IBInspectable public var backgroundBarColor: UIColor = .systemGray5 { didSet { setNeedsDisplay() } }
    @IBInspectable public var lineWidth: CGFloat = 8 { didSet { setNeedsDisplay() } }
    @IBInspectable public var lineCapRaw: Int = Int(CGLineCap.round.rawValue) { didSet { setNeedsDisplay() } }
    @IBInspectable public var animationDuration: Double = 1.0
    public var animationType: ProgressBarAnimationTypeUIKit = .simple

    private var animatedProgress: CGFloat = 0.0
    private var isForward: Bool = true
    private var isAnimating: Bool = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    public override func draw(_ rect: CGRect) {
        let cap = CGLineCap(rawValue: Int32(CGFloat(lineCapRaw))) ?? .round
        let context = UIGraphicsGetCurrentContext()
        let y = rect.height / 2
        let start = CGPoint(x: lineWidth/2, y: y)
        let end = CGPoint(x: rect.width - lineWidth/2, y: y)
        // Draw background
        context?.setLineWidth(lineWidth)
        context?.setLineCap(cap)
        context?.setStrokeColor(backgroundBarColor.cgColor)
        context?.move(to: start)
        context?.addLine(to: end)
        context?.strokePath()
        // Draw progress
        let progressEnd = CGPoint(x: start.x + (rect.width - lineWidth) * animatedProgress, y: y)
        context?.setStrokeColor(barColor.cgColor)
        context?.move(to: start)
        context?.addLine(to: progressEnd)
        context?.strokePath()
    }

    private func animateIfNeeded() {
        switch animationType {
        case .none:
            animatedProgress = progress
            setNeedsDisplay()
        case .simple:
            UIView.animate(withDuration: animationDuration) {
                self.animatedProgress = self.progress
                self.setNeedsDisplay()
            }
        case .forwardBackward:
            if !isAnimating {
                isAnimating = true
                animateForwardBackward()
            }
        }
    }

    private func animateForwardBackward() {
        let target: CGFloat = isForward ? 1.0 : 0.0
        UIView.animate(withDuration: animationDuration, animations: {
            self.animatedProgress = target
            self.setNeedsDisplay()
        }, completion: { _ in
            self.isForward.toggle()
            self.animateForwardBackward()
        })
    }

    // For Interface Builder
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        animatedProgress = progress
        setNeedsDisplay()
    }

    // For programmatic updates
    public func setProgress(_ progress: CGFloat, animated: Bool = true) {
        self.progress = min(max(progress, 0.0), 1.0)
        if !animated {
            animatedProgress = self.progress
            setNeedsDisplay()
        }
    }
}

@available(iOS 13.0, *)
@IBDesignable
public class CircularProgressView: UIView {
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet { setNeedsDisplay(); animateIfNeeded() }
    }
    @IBInspectable public var barColor: UIColor = .systemBlue { didSet { setNeedsDisplay() } }
    @IBInspectable public var backgroundBarColor: UIColor = .systemGray5 { didSet { setNeedsDisplay() } }
    @IBInspectable public var lineWidth: CGFloat = 8 { didSet { setNeedsDisplay() } }
    @IBInspectable public var lineCapRaw: Int = Int(CGLineCap.round.rawValue) { didSet { setNeedsDisplay() } }
    @IBInspectable public var animationDuration: Double = 1.0
    public var animationType: ProgressBarAnimationTypeUIKit = .simple
    public var gradientColors: [UIColor]? = nil // Optional gradient

    private var animatedProgress: CGFloat = 0.0
    private var isForward: Bool = true
    private var isAnimating: Bool = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    public override func draw(_ rect: CGRect) {
        let cap = CGLineCap(rawValue: Int32(CGFloat(lineCapRaw))) ?? .round
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 - lineWidth / 2
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * .pi
        // Draw background circle
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        backgroundPath.lineWidth = lineWidth
        backgroundPath.lineCapStyle = cap
        backgroundBarColor.setStroke()
        backgroundPath.stroke()
        // Draw progress
        let progressEndAngle = startAngle + 2 * .pi * animatedProgress
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressEndAngle, clockwise: true)
        progressPath.lineWidth = lineWidth
        progressPath.lineCapStyle = cap
        if let colors = gradientColors, colors.count > 1, let ctx = UIGraphicsGetCurrentContext() {
            ctx.saveGState()
            ctx.addPath(progressPath.cgPath)
            ctx.replacePathWithStrokedPath()
            ctx.clip()
            let cgColors = colors.map { $0.cgColor } as CFArray
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgColors, locations: nil)
            ctx.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: rect.width, y: rect.height), options: [])
            ctx.restoreGState()
        } else {
            barColor.setStroke()
            progressPath.stroke()
        }
    }

    private func animateIfNeeded() {
        switch animationType {
        case .none:
            animatedProgress = progress
            setNeedsDisplay()
        case .simple:
            UIView.animate(withDuration: animationDuration) {
                self.animatedProgress = self.progress
                self.setNeedsDisplay()
            }
        case .forwardBackward:
            if !isAnimating {
                isAnimating = true
                animateForwardBackward()
            }
        }
    }

    private func animateForwardBackward() {
        let target: CGFloat = isForward ? 1.0 : 0.0
        UIView.animate(withDuration: animationDuration, animations: {
            self.animatedProgress = target
            self.setNeedsDisplay()
        }, completion: { _ in
            self.isForward.toggle()
            self.animateForwardBackward()
        })
    }

    // For Interface Builder
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        animatedProgress = progress
        setNeedsDisplay()
    }

    // For programmatic updates
    public func setProgress(_ progress: CGFloat, animated: Bool = true) {
        self.progress = min(max(progress, 0.0), 1.0)
        if !animated {
            animatedProgress = self.progress
            setNeedsDisplay()
        }
    }
}

@available(iOS 13.0, *)
@IBDesignable
public class ArcProgressView: UIView {
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet { setNeedsDisplay(); animateIfNeeded() }
    }
    @IBInspectable public var barColor: UIColor = .systemBlue { didSet { setNeedsDisplay() } }
    @IBInspectable public var backgroundBarColor: UIColor = .systemGray5 { didSet { setNeedsDisplay() } }
    @IBInspectable public var lineWidth: CGFloat = 8 { didSet { setNeedsDisplay() } }
    @IBInspectable public var lineCapRaw: Int = Int(CGLineCap.round.rawValue) { didSet { setNeedsDisplay() } }
    @IBInspectable public var animationDuration: Double = 1.0
    @IBInspectable public var startAngle: CGFloat = 180 { didSet { setNeedsDisplay() } } // degrees
    @IBInspectable public var endAngle: CGFloat = 360 { didSet { setNeedsDisplay() } } // degrees
    public var animationType: ProgressBarAnimationTypeUIKit = .simple
    public var gradientColors: [UIColor]? = nil // Optional gradient

    private var animatedProgress: CGFloat = 0.0
    private var isForward: Bool = true
    private var isAnimating: Bool = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    public override func draw(_ rect: CGRect) {
        let cap = CGLineCap(rawValue: Int32(CGFloat(lineCapRaw))) ?? .round
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 - lineWidth / 2
        let start = (startAngle - 90) * .pi / 180 // convert to radians, -90 to start at top
        let end = (endAngle - 90) * .pi / 180
        // Draw background arc
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        backgroundPath.lineWidth = lineWidth
        backgroundPath.lineCapStyle = cap
        backgroundBarColor.setStroke()
        backgroundPath.stroke()
        // Draw progress arc
        let totalAngle = end - start
        let progressEnd = start + totalAngle * animatedProgress
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: progressEnd, clockwise: true)
        progressPath.lineWidth = lineWidth
        progressPath.lineCapStyle = cap
        if let colors = gradientColors, colors.count > 1, let ctx = UIGraphicsGetCurrentContext() {
            ctx.saveGState()
            ctx.addPath(progressPath.cgPath)
            ctx.replacePathWithStrokedPath()
            ctx.clip()
            let cgColors = colors.map { $0.cgColor } as CFArray
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgColors, locations: nil)
            ctx.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: rect.width, y: rect.height), options: [])
            ctx.restoreGState()
        } else {
            barColor.setStroke()
            progressPath.stroke()
        }
    }

    private func animateIfNeeded() {
        switch animationType {
        case .none:
            animatedProgress = progress
            setNeedsDisplay()
        case .simple:
            UIView.animate(withDuration: animationDuration) {
                self.animatedProgress = self.progress
                self.setNeedsDisplay()
            }
        case .forwardBackward:
            if !isAnimating {
                isAnimating = true
                animateForwardBackward()
            }
        }
    }

    private func animateForwardBackward() {
        let target: CGFloat = isForward ? 1.0 : 0.0
        UIView.animate(withDuration: animationDuration, animations: {
            self.animatedProgress = target
            self.setNeedsDisplay()
        }, completion: { _ in
            self.isForward.toggle()
            self.animateForwardBackward()
        })
    }

    // For Interface Builder
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        animatedProgress = progress
        setNeedsDisplay()
    }

    // For programmatic updates
    public func setProgress(_ progress: CGFloat, animated: Bool = true) {
        self.progress = min(max(progress, 0.0), 1.0)
        if !animated {
            animatedProgress = self.progress
            setNeedsDisplay()
        }
    }
}

#endif

#if canImport(SwiftUI)
import SwiftUI

public enum ProgressBarAnimationType {
    case none
    case simple
    case forwardBackward
}

@available(iOS 14.0, *)
public struct HorizontalProgressBar: View {
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
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(backgroundColor)
                    .frame(height: lineWidth)
                if let gradient = foregroundGradient {
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
                        .frame(width: geometry.size.width * animatedProgress, height: lineWidth)
                } else {
                    Capsule()
                        .fill(barColor)
                        .frame(width: geometry.size.width * animatedProgress, height: lineWidth)
                }
            }
            .frame(height: lineWidth)
            .onAppear {
                setupAnimation()
            }
            .onChange(of: progress) { _ in
                setupAnimation()
            }
        }
        .frame(height: lineWidth)
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
public extension HorizontalProgressBar {
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
}

@available(iOS 14.0, *)
public struct CircularProgressBar: View {
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
        ZStack {
            Circle()
                .stroke(backgroundColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
            if let gradient = foregroundGradient {
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(AngularGradient(gradient: Gradient(colors: gradient), center: .center), style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
                    .rotationEffect(.degrees(-90))
            } else {
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(barColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
                    .rotationEffect(.degrees(-90))
            }
        }
        .onAppear { setupAnimation() }
        .onChange(of: progress) { _ in setupAnimation() }
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
public extension CircularProgressBar {
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
}

@available(iOS 14.0, *)
public struct ArcProgressBar: View {
    @Binding var progress: CGFloat // 0.0 to 1.0
    var barColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.2)
    var lineWidth: CGFloat = 8
    var lineCap: CGLineCap = .round
    var animationType: ProgressBarAnimationType = .simple
    var animationDuration: Double = 1.0
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
                animationType: ProgressBarAnimationType = .simple,
                animationDuration: Double = 1.0,
                startAngle: Angle = .degrees(180),
                endAngle: Angle = .degrees(360),
                foregroundGradient: [Color]? = nil) {
        self._progress = progress
        self.barColor = barColor
        self.backgroundColor = backgroundColor
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.animationType = animationType
        self.animationDuration = animationDuration
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
public extension ArcProgressBar {
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
    func startAngle(_ angle: Angle) -> Self {
        var copy = self
        copy.startAngle = angle
        return copy
    }
    func endAngle(_ angle: Angle) -> Self {
        var copy = self
        copy.endAngle = angle
        return copy
    }
    func foregroundGradient(_ colors: [Color]) -> Self {
        var copy = self
        copy.foregroundGradient = colors
        return copy
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
}
#endif
