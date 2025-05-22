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
public struct EasyProgressBar: View {
    
    @Binding var progress: CGFloat
    private(set) var barStyle: EasyProgressBarStyle = .horizontal
    // Common
    private(set) var barColor: Color = .blue
    private(set) var backgroundColor: Color = .gray.opacity(0.2)
    private(set) var lineWidth: CGFloat = 8
    private(set) var lineCap: CGLineCap = .round
    private(set) var animationType: ProgressBarAnimationType = .simple(duration: 1)
    private(set) var foregroundGradient: [Color]? = nil
    // Arc-specific
    private(set) var startAngle: Angle = .degrees(180)
    private(set) var endAngle: Angle = .degrees(360)
    
    public init(progress: Binding<CGFloat>) {
        self._progress = progress
    }
    
    public var body: some View {
        Group {
            switch barStyle {
            case .horizontal:
                HorizontalProgressBar(
                    progress: $progress,
                    barColor: barColor,
                    backgroundColor: backgroundColor,
                    lineWidth: lineWidth,
                    lineCap: lineCap,
                    animationType: animationType,
                    foregroundGradient: foregroundGradient
                )
            case .vertical:
                VerticalProgressBar(
                    progress: $progress,
                    barColor: barColor,
                    backgroundColor: backgroundColor,
                    lineWidth: lineWidth,
                    lineCap: lineCap,
                    animationType: animationType,
                    foregroundGradient: foregroundGradient
                )
            case .circular:
                CircularProgressBar(
                    progress: $progress,
                    barColor: barColor,
                    backgroundColor: backgroundColor,
                    lineWidth: lineWidth,
                    lineCap: lineCap,
                    animationType: animationType,
                    foregroundGradient: foregroundGradient
                )
            case .arc:
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
    
    public func lineWidth(_ progress: CGFloat) -> EasyProgressBar {
        then({ $0.lineWidth = lineWidth })
    }
    
    public func lineCap(_ lineCap: CGLineCap) -> EasyProgressBar {
        then({ $0.lineCap = lineCap })
    }
    
    public func animationType(_ animationType: ProgressBarAnimationType) -> EasyProgressBar {
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
    
    func barShadow(color: Color = .black, radius: CGFloat = 4, x: CGFloat = 0, y: CGFloat = 2) -> EasyProgressBar {
        self.shadow(color: color, radius: radius, x: x, y: y) as! EasyProgressBar
    }
    func barGlow(color: Color = .blue, radius: CGFloat = 10) -> EasyProgressBar {
        self.shadow(color: color, radius: radius) as! EasyProgressBar
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
