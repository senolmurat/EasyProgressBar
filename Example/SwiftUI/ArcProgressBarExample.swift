import SwiftUI

struct ArcProgressBarExample: View {
    @State private var progress: CGFloat = 0.5

    var body: some View {
        VStack(spacing: 40) {
            Text("Simple Animated Arc Progress Bar")
                .font(.headline)
            ArcProgressBar(progress: $progress)
                .barColor(.orange)
                .backgroundColor(.gray.opacity(0.2))
                .lineWidth(14)
                .startAngle(.degrees(180))
                .endAngle(.degrees(360))
                .animationType(.simple)
                .animationDuration(1.0)
                .frame(width: 160, height: 80)

            Button("Increase Progress") {
                withAnimation {
                    progress = min(progress + 0.2, 1.0)
                }
            }
            .buttonStyle(.borderedProminent)

            Text("Forward-Backward Animated Arc Progress Bar")
                .font(.headline)
            ArcProgressBar(progress: $progress)
                .barColor(.green)
                .backgroundColor(.gray.opacity(0.1))
                .lineWidth(10)
                .startAngle(.degrees(0))
                .endAngle(.degrees(270))
                .animationType(.forwardBackward)
                .animationDuration(1.5)
                .frame(width: 140, height: 140)

            Text("Gradient Arc Progress Bar")
                .font(.headline)
            ArcProgressBar(progress: $progress)
                .foregroundGradient([.red, .yellow, .orange, .purple])
                .backgroundColor(.gray.opacity(0.15))
                .lineWidth(16)
                .startAngle(.degrees(90))
                .endAngle(.degrees(270))
                .animationType(.simple)
                .animationDuration(1.2)
                .frame(width: 180, height: 180)
        }
        .padding()
    }
}

struct ArcProgressBarExample_Previews: PreviewProvider {
    static var previews: some View {
        ArcProgressBarExample()
    }
} 