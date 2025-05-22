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
    var barStyle: ProgressBarStyle = .horizontal
    // Common
    var barColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.2)
    var lineWidth: CGFloat = 8
    var lineCap: CGLineCap = .round
    var animationType: ProgressBarAnimationType = .simple
    var animationDuration: Double = 1.0
    var foregroundGradient: [Color]? = nil
    // Arc-specific
    var startAngle: Angle = .degrees(180)
    var endAngle: Angle = .degrees(360)
    
    public init(
        progress: Binding<CGFloat>,
        barStyle: ProgressBarStyle = .horizontal,
        barColor: Color = .blue,
        backgroundColor: Color = .gray.opacity(0.2),
        lineWidth: CGFloat = 8,
        lineCap: CGLineCap = .round,
        animationType: ProgressBarAnimationType = .simple,
        animationDuration: Double = 1.0,
        foregroundGradient: [Color]? = nil,
        startAngle: Angle = .degrees(180),
        endAngle: Angle = .degrees(360)
    ) {
        self._progress = progress
        self.barStyle = barStyle
        self.barColor = barColor
        self.backgroundColor = backgroundColor
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.animationType = animationType
        self.animationDuration = animationDuration
        self.foregroundGradient = foregroundGradient
        self.startAngle = startAngle
        self.endAngle = endAngle
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
                    animationDuration: animationDuration,
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
                    animationDuration: animationDuration,
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
                    animationDuration: animationDuration,
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
                    animationDuration: animationDuration,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    foregroundGradient: foregroundGradient
                )
            }
        }
    }
}
#endif
