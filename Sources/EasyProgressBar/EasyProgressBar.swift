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

// MARK: - EasyProgressView class implementation -
open class HorizontalProgressBar: UIView {
    
    public enum ProgressBarDirection {
        case leftToRight
        case rightToLeft
    }
    
    public struct Configuration {
        
        public struct Drawing {
            public var cornerRadius        = CGFloat(2)
            public var foregroundColor     = UIColor.white
            public var gradientColors      = [UIColor.white, UIColor.white]
            public var backgroundColor     = UIColor.red
            public var textAlignment       = NSTextAlignment.center
            public var borderWidth         = CGFloat(0)
            public var borderColor         = UIColor.clear
            public var font                = UIFont.systemFont(ofSize: 15)
            public var shadowColor         = UIColor.clear
            public var shadowOffset        = CGSize(width: 0.0, height: 0.0)
            public var shadowRadius        = CGFloat(0)
            public var shadowOpacity       = CGFloat(0)
        }
        
        public struct Positioning {
            public var contentInsets        = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            public var maxWidth             = CGFloat(200)
        }
        
        public struct Animating {
            public var dismissTransform     = CGAffineTransform(scaleX: 0.1, y: 0.1)
            public var showInitialTransform = CGAffineTransform(scaleX: 0, y: 0)
            public var showFinalTransform   = CGAffineTransform.identity
            public var springDamping        = CGFloat(0.7)
            public var springVelocity       = CGFloat(0.7)
            public var showInitialAlpha     = CGFloat(0)
            public var dismissFinalAlpha    = CGFloat(0)
            public var showDuration         = 0.7
            public var dismissDuration      = 0.7
            public var dismissOnTap         = true
        }
        
        public var drawing      = Drawing()
        public var positioning  = Positioning()
        public var animating    = Animating()
        public var hasBorder : Bool {
            return drawing.borderWidth > 0 && drawing.borderColor != UIColor.clear
        }
        
        public var hasShadow : Bool {
            return drawing.shadowOpacity > 0 && drawing.shadowColor != UIColor.clear
        }
        
        public init() {}
    }
    
    // MARK: - Variables -
    
    override open var backgroundColor: UIColor? {
        didSet {
            guard let color = backgroundColor
                  , color != UIColor.clear else {return}
            
            configuration.drawing.backgroundColor = color
            backgroundColor = UIColor.clear
        }
    }
    
    fileprivate weak var presentingView: UIView?
    fileprivate weak var delegate: EasyProgressBarDelegate?
    fileprivate(set) open var configuration: Configuration
    
    // MARK: - Lazy variables -
    fileprivate lazy var contentSize: CGSize = {
        
        [unowned self] in
        return self.frame.size
    }()
    
    fileprivate lazy var tipViewSize: CGSize = {
        
        [unowned self] in
        
        var tipViewSize =
            CGSize(
                width: self.contentSize.width + self.configuration.positioning.contentInsets.left + self.configuration.positioning.contentInsets.right,
                height: self.contentSize.height + self.configuration.positioning.contentInsets.top + self.configuration.positioning.contentInsets.bottom)
        
        return tipViewSize
    }()
    
    // MARK: - Static variables -
    
    public static var globalConfiguration = Configuration()
    
    // MARK:- Initializer -
    
    public init (frame: CGRect, configuration: Configuration = HorizontalProgressBar.globalConfiguration, delegate: EasyProgressBarDelegate? = nil) {
        
        self.configuration = configuration
        self.delegate = delegate
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    deinit
    {
        
    }
    
    // MARK: - Callbacks -
    
    @objc func handleTap() {
        self.delegate?.easyProgressBarDidTap(self)
    }
    
    // MARK: - Drawing -
    fileprivate func drawBorder(_ borderPath: CGPath, context: CGContext) {
        context.addPath(borderPath)
        context.setStrokeColor(configuration.drawing.borderColor.cgColor)
        context.setLineWidth(configuration.drawing.borderWidth)
        context.strokePath()
    }
    
    fileprivate func drawText(_ progressFrame: CGRect, context : CGContext) {
        //guard case .text(let text) = content else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = configuration.drawing.textAlignment
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let textRect = getContentRect(from: progressFrame)
        
        #if swift(>=4.2)
        let attributes = [NSAttributedString.Key.font : configuration.drawing.font, NSAttributedString.Key.foregroundColor : configuration.drawing.foregroundColor, NSAttributedString.Key.paragraphStyle : paragraphStyle]
        #else
        let attributes = [NSAttributedStringKey.font : preferences.drawing.font, NSAttributedStringKey.foregroundColor : preferences.drawing.foregroundColor, NSAttributedStringKey.paragraphStyle : paragraphStyle]
        #endif
        
        text.draw(in: textRect, withAttributes: attributes)
    }

    fileprivate func drawAttributedText(_ bubbleFrame: CGRect, context : CGContext) {
        guard
            case .attributedText(let text) = content
            else {
                return
        }

        let textRect = getContentRect(from: bubbleFrame)

        text.draw(with: textRect, options: .usesLineFragmentOrigin, context: .none)
    }

    fileprivate func drawShadow() {
        if configuration.hasShadow {
            self.layer.masksToBounds = false
            self.layer.shadowColor = configuration.drawing.shadowColor.cgColor
            self.layer.shadowOffset = configuration.drawing.shadowOffset
            self.layer.shadowRadius = configuration.drawing.shadowRadius
            self.layer.shadowOpacity = Float(configuration.drawing.shadowOpacity)
        }
    }
    
    override open func draw(_ rect: CGRect) {
        
        let bubbleFrame = getBubbleFrame()
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState ()
        
        drawBubble(bubbleFrame, arrowPosition: preferences.drawing.arrowPosition, context: context)
        
        switch content {
        case .text:
            drawText(bubbleFrame, context: context)
        case .attributedText:
            drawAttributedText(bubbleFrame, context: context)
        case .view (let view):
            addSubview(view)
        }
        
        drawShadow()
        context.restoreGState()
    }
    
    private func getContentRect(from progressFrame: CGRect) -> CGRect {
        return CGRect(x: progressFrame.origin.x + configuration.positioning.contentInsets.left, y: progressFrame.origin.y + configuration.positioning.contentInsets.top, width: contentSize.width, height: contentSize.height)
    }
    
    // -------------
    
    private var progressLayer = CAGradientLayer()
    private var maskLayer = CALayer()
    private var progressValue: CGFloat = 0.0
    public weak var delegate: EasyProgressBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    /// Colors of the progress bar.
    ///
    /// Use *backgroundColor* of the view instead to set color the of bar background.
    public var colors: [UIColor] = [.appleGreen, .avocadoGreen] {
        didSet {
            if colors.count == 1 {
                colors.append(colors.first ?? .clear)
            }
            updateLayers()
            setNeedsDisplay()
        }
    }
    
    /// Use it to set the progress Value of the bar, will be clamped to *0...1* range.
    /// To animate progress, user *animate()* function.
    public var progress: CGFloat {
        get {
            progressValue
        }
        set {
            progressValue = newValue.clamped(to: 0...1)
            setNeedsDisplay()
        }
    }
    
    private func setupLayers() {
        progressLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        progressLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        progressLayer.anchorPoint = .init(x: 0, y: 0.5)
        progressLayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.height))
        
        maskLayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.height))
        maskLayer.backgroundColor = UIColor.white.cgColor
        maskLayer.anchorPoint = .init(x: 0, y: 0.5)
        progressLayer.mask = maskLayer
        
        cornerRadius = 4
        backgroundColor = .putty
        layer.addSublayer(progressLayer)
    }
    
    private func updateLayers() {
        progressLayer.colors = colors.map(\.cgColor)
    }
    
    public override func draw(_ rect: CGRect) {
        let maskRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        maskLayer.frame = maskRect
    }
    
    /// Func to call to animate the progress  over a *duration* to a *value*.
    /// - Parameters:
    ///   - duration: Duration to run the animation for in seconds
    ///   - value: Progress value to animate to
    public func animate(for duration: TimeInterval, withDelay delay: CGFloat = 0, to value: CGFloat = 1.0) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            CATransaction.begin()
            
            let boundsAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.bounds))
            boundsAnimation.fromValue = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width * progress, height: bounds.height))
            boundsAnimation.toValue = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width * value, height: bounds.height))
            boundsAnimation.duration = duration
            boundsAnimation.isRemovedOnCompletion = false
            boundsAnimation.fillMode = .forwards
            
            boundsAnimation.beginTime = CACurrentMediaTime() + delay
            
            CATransaction.setCompletionBlock {
                self.progress = value
                self.delegate?.didAnimationCompleteWith(finalValue: value, self, self.progressLayer)
            }
            
            maskLayer.add(boundsAnimation, forKey: #keyPath(CALayer.bounds))
            CATransaction.commit()
        }
    }
}

public extension HorizontalProgressBar {

}

// MARK: Protocol
public protocol EasyProgressBarDelegate : AnyObject {
    func easyProgressBarDidTap(_ progressBar: HorizontalProgressBar)
    func didAnimationComplete(finalValue: CGFloat, _ progressBar: HorizontalProgressBar, _ layer: CALayer)
}
#endif
