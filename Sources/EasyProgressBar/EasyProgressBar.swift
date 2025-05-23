//
//  EasyProgressBar.swift
//  EasyProgressBar
//
//  Created by Murat ŞENOL on 2024-05-16.
//

#if canImport(SwiftUI)
import SwiftUI

/// A unified progress bar view supporting multiple styles (horizontal, vertical, circular, arc).
@available(iOS 14.0, *)
public struct EasyProgressBar<Content: View>: View {
    
    let content: Content
    @Binding var progress: CGFloat
    private(set) var barStyle: EasyProgressBarStyle = .horizontal
    // Common
    private(set) var barColor: Color = .blue
    private(set) var backgroundColor: Color = .gray.opacity(0.2)
    private(set) var lineWidth: CGFloat = 8
    private(set) var lineCap: CGLineCap = .round
    private(set) var animationType: EasyProgressBarAnimationType = .simple(duration: 1)
    private(set) var foregroundGradient: [Color]? = nil
    
    // Arc-specific
    /// Start angle of the arc
    private(set) var startAngle: Angle = .degrees(180)
    /// End angle of the arc
    private(set) var endAngle: Angle = .degrees(360)
    
    public init(progress: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._progress = progress
        self.content = content()
    }
    
    public var body: some View {
        Group {
            switch barStyle {
            case .horizontal:
                VStack(spacing: 8) {
                    HStack {
                        content
                        Spacer()
                    }
                    HorizontalProgressBar(
                        progress: $progress,
                        barColor: barColor,
                        backgroundColor: backgroundColor,
                        lineWidth: lineWidth,
                        lineCap: lineCap,
                        animationType: animationType,
                        foregroundGradient: foregroundGradient
                    )
                }
            case .vertical:
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        VerticalProgressBar(
                            progress: $progress,
                            barColor: barColor,
                            backgroundColor: backgroundColor,
                            lineWidth: lineWidth,
                            lineCap: lineCap,
                            animationType: animationType,
                            foregroundGradient: foregroundGradient
                        )
                        Spacer()
                    }
                    content
                }
            case .circular:
                ZStack {
                    content
                    CircularProgressBar(
                        progress: $progress,
                        barColor: barColor,
                        backgroundColor: backgroundColor,
                        lineWidth: lineWidth,
                        lineCap: lineCap,
                        animationType: animationType,
                        foregroundGradient: foregroundGradient
                    )
                }
            case .arc:
                ZStack {
                    content
                    ArcProgressBar(
                        progress: $progress,
                        barColor: barColor,
                        backgroundColor: backgroundColor,
                        lineWidth: lineWidth,
                        lineCap: lineCap,
                        animationType: animationType,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        foregroundGradient: foregroundGradient
                    )
                }
            }
        }
    }
}

@available(iOS 14.0, *)
public extension EasyProgressBar where Content == EmptyView {
    init(progress: Binding<CGFloat>) {
        self.init(progress: progress, content: {EmptyView()})
    }
}

@available(iOS 14.0, *)
extension EasyProgressBar {
    public func progress(_ progress: CGFloat) -> EasyProgressBar {
        then({ $0.progress = progress })
    }
    
    public func barStyle(_ barStyle: EasyProgressBarStyle) -> EasyProgressBar {
        then({ $0.barStyle = barStyle })
    }
    
    public func barColor(_ barColor: Color) -> EasyProgressBar {
        then({ $0.barColor = barColor })
    }
    
    public func backColor(_ backColor: Color) -> EasyProgressBar {
        then({ $0.backgroundColor = backColor })
    }
    
    public func lineWidth(_ lineWidth: CGFloat) -> EasyProgressBar {
        then({ $0.lineWidth = lineWidth })
    }
    
    public func lineCap(_ lineCap: CGLineCap) -> EasyProgressBar {
        then({ $0.lineCap = lineCap })
    }
    
    public func animationType(_ animationType: EasyProgressBarAnimationType) -> EasyProgressBar {
        then({ $0.animationType = animationType })
    }
    
    public func barGradientColors(_ colors: [Color]) -> EasyProgressBar {
        then({ $0.foregroundGradient = colors })
    }
    
    public func startAngle(_ startAngle: Angle) -> EasyProgressBar {
        then({ $0.startAngle = startAngle })
    }
    
    public func endAngle(_ endAngle: Angle) -> EasyProgressBar {
        then({ $0.endAngle = endAngle })
    }
}

@available(iOS 14.0, *)
extension View {
    @inlinable
    public func then(_ body: (inout Self) -> Void) -> Self {
        var result = self
        
        body(&result)
        
        return result
    }
}
#endif
