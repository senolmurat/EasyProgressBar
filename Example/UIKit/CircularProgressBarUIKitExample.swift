import UIKit
import EasyProgressBar

class CircularProgressBarUIKitExampleViewController: UIViewController {
    let progressBar = CircularProgressView()
    let forwardBackwardBar = CircularProgressView()
    let button = UIButton(type: .system)
    var progress: CGFloat = 0.6

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Simple animated circular progress bar
        progressBar.frame = CGRect(x: 40, y: 120, width: 120, height: 120)
        progressBar.barColor = .systemPurple
        progressBar.backgroundBarColor = .systemGray5
        progressBar.lineWidth = 14
        progressBar.animationType = .simple
        progressBar.animationDuration = 1.0
        progressBar.setProgress(progress, animated: false)
        view.addSubview(progressBar)

        // Button to increase progress
        button.setTitle("Increase Progress", for: .normal)
        button.frame = CGRect(x: 40, y: 260, width: 160, height: 44)
        button.addTarget(self, action: #selector(increaseProgress), for: .touchUpInside)
        view.addSubview(button)

        // Forward-backward animated circular progress bar
        forwardBackwardBar.frame = CGRect(x: 200, y: 120, width: 100, height: 100)
        forwardBackwardBar.barColor = .systemGreen
        forwardBackwardBar.backgroundBarColor = .systemGray6
        forwardBackwardBar.lineWidth = 10
        forwardBackwardBar.animationType = .forwardBackward
        forwardBackwardBar.animationDuration = 1.5
        forwardBackwardBar.setProgress(progress, animated: false)
        view.addSubview(forwardBackwardBar)

        // Gradient circular progress bar
        let gradientBar = CircularProgressView()
        gradientBar.frame = CGRect(x: 120, y: 260, width: 140, height: 140)
        gradientBar.gradientColors = [.systemBlue, .systemCyan, .systemMint, .systemPurple]
        gradientBar.backgroundBarColor = .systemGray4
        gradientBar.lineWidth = 16
        gradientBar.animationType = .simple
        gradientBar.animationDuration = 1.2
        gradientBar.setProgress(progress, animated: false)
        view.addSubview(gradientBar)
    }

    @objc func increaseProgress() {
        progress = min(progress + 0.2, 1.0)
        progressBar.setProgress(progress, animated: true)
        // forwardBackwardBar and gradientBar animate independently
    }
} 