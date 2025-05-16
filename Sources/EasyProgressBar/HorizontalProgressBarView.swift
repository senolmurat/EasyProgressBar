//
//  HorizontalProgressView.swift
//  EasyProgressBar
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

@available(iOS 13.0, *)
@IBDesignable
open class HorizontalProgressView: UIView {
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
#endif
