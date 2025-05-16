import UIKit
import EasyProgressBar

class VerticalProgressBarUIKitExampleViewController: UIViewController {
    let progressBar = VerticalProgressView()
    let forwardBackwardBar = VerticalProgressView()
    let button = UIButton(type: .system)
    var progress: CGFloat = 0.4

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Simple animated vertical progress bar
        progressBar.frame = CGRect(x: 60, y: 120, width: 40, height: 200)
        progressBar.barColor = .systemBlue
        progressBar.backgroundBarColor = .systemGray5
        progressBar.lineWidth = 24
        progressBar.animationType = .simple
        progressBar.animationDuration = 1.0
        progressBar.setProgress(progress, animated: false)
        view.addSubview(progressBar)

        // Button to increase progress
        button.setTitle("Increase Progress", for: .normal)
        button.frame = CGRect(x: 40, y: 340, width: 120, height: 44)
        button.addTarget(self, action: #selector(increaseProgress), for: .touchUpInside)
        view.addSubview(button)

        // Forward-backward animated vertical progress bar
        forwardBackwardBar.frame = CGRect(x: 160, y: 120, width: 36, height: 180)
        forwardBackwardBar.barColor = .systemGreen
        forwardBackwardBar.backgroundBarColor = .systemGray6
        forwardBackwardBar.lineWidth = 20
        forwardBackwardBar.animationType = .forwardBackward
        forwardBackwardBar.animationDuration = 1.5
        forwardBackwardBar.setProgress(progress, animated: false)
        view.addSubview(forwardBackwardBar)

        // Gradient vertical progress bar
        let gradientBar = VerticalProgressView()
        gradientBar.frame = CGRect(x: 240, y: 120, width: 44, height: 220)
        gradientBar.gradientColors = [.systemPurple, .systemPink, .systemOrange]
        gradientBar.backgroundBarColor = .systemGray4
        gradientBar.lineWidth = 28
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