import SwiftUI

struct HorizontalProgressBarExample: View {
    @State private var progress: CGFloat = 0.3

    var body: some View {
        VStack(spacing: 40) {
            Text("Simple Animated Progress Bar")
                .font(.headline)
            HorizontalProgressBar(progress: $progress)
                .barColor(.blue)
                .backgroundColor(.gray.opacity(0.2))
                .lineWidth(12)
                .animationType(.simple)
                .animationDuration(1.0)
                .padding(.horizontal)

            Button("Increase Progress") {
                withAnimation {
                    progress = min(progress + 0.2, 1.0)
                }
            }
            .buttonStyle(.borderedProminent)

            Text("Forward-Backward Animated Progress Bar")
                .font(.headline)
            HorizontalProgressBar(progress: $progress)
                .barColor(.green)
                .backgroundColor(.gray.opacity(0.1))
                .lineWidth(10)
                .animationType(.forwardBackward)
                .animationDuration(1.5)
                .padding(.horizontal)

            Text("Gradient Horizontal Progress Bar")
                .font(.headline)
            HorizontalProgressBar(progress: $progress)
                .foregroundGradient([.purple, .blue, .cyan, .mint])
                .backgroundColor(.gray.opacity(0.15))
                .lineWidth(14)
                .animationType(.simple)
                .animationDuration(1.2)
                .padding(.horizontal)
        }
        .padding()
    }
}

struct HorizontalProgressBarExample_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressBarExample()
    }
} 
