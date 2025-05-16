import SwiftUI

struct CircularProgressBarExample: View {
    @State private var progress: CGFloat = 0.4

    var body: some View {
        VStack(spacing: 40) {
            Text("Simple Animated Circular Progress Bar")
                .font(.headline)
            CircularProgressBar(progress: $progress)
                .barColor(.purple)
                .backgroundColor(.gray.opacity(0.2))
                .lineWidth(14)
                .animationType(.simple)
                .animationDuration(1.0)
                .frame(width: 120, height: 120)

            Button("Increase Progress") {
                withAnimation {
                    progress = min(progress + 0.2, 1.0)
                }
            }
            .buttonStyle(.borderedProminent)

            Text("Forward-Backward Animated Circular Progress Bar")
                .font(.headline)
            CircularProgressBar(progress: $progress)
                .barColor(.green)
                .backgroundColor(.gray.opacity(0.1))
                .lineWidth(10)
                .animationType(.forwardBackward)
                .animationDuration(1.5)
                .frame(width: 100, height: 100)

            Text("Gradient Circular Progress Bar")
                .font(.headline)
            CircularProgressBar(progress: $progress)
                .foregroundGradient([.blue, .cyan, .mint, .purple])
                .backgroundColor(.gray.opacity(0.15))
                .lineWidth(16)
                .animationType(.simple)
                .animationDuration(1.2)
                .frame(width: 140, height: 140)
        }
        .padding()
    }
}

struct CircularProgressBarExample_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBarExample()
    }
} 