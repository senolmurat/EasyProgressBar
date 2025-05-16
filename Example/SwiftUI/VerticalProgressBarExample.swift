import SwiftUI

struct VerticalProgressBarExample: View {
    @State private var progress: CGFloat = 0.4

    var body: some View {
        VStack(spacing: 40) {
            Text("Simple Animated Vertical Progress Bar")
                .font(.headline)
            VerticalProgressBar(progress: $progress)
                .barColor(.blue)
                .backgroundColor(.gray.opacity(0.2))
                .lineWidth(24)
                .animationType(.simple)
                .animationDuration(1.0)
                .frame(width: 40, height: 200)

            Button("Increase Progress") {
                withAnimation {
                    progress = min(progress + 0.2, 1.0)
                }
            }
            .buttonStyle(.borderedProminent)

            Text("Forward-Backward Animated Vertical Progress Bar")
                .font(.headline)
            VerticalProgressBar(progress: $progress)
                .barColor(.green)
                .backgroundColor(.gray.opacity(0.1))
                .lineWidth(20)
                .animationType(.forwardBackward)
                .animationDuration(1.5)
                .frame(width: 36, height: 180)

            Text("Gradient Vertical Progress Bar")
                .font(.headline)
            VerticalProgressBar(progress: $progress)
                .foregroundGradient([.purple, .pink, .orange])
                .backgroundColor(.gray.opacity(0.15))
                .lineWidth(28)
                .animationType(.simple)
                .animationDuration(1.2)
                .frame(width: 44, height: 220)
        }
        .padding()
    }
}

struct VerticalProgressBarExample_Previews: PreviewProvider {
    static var previews: some View {
        VerticalProgressBarExample()
    }
} 