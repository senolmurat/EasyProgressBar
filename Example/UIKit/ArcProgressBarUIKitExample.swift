import UIKit
import EasyProgressBar

class ArcProgressBarUIKitExampleViewController: UIViewController {
    let progressBar = ArcProgressView()
    let forwardBackwardBar = ArcProgressView()
    let button = UIButton(type: .system)
    var progress: CGFloat = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Simple animated arc progress bar
        progressBar.frame = CGRect(x: 40, y: 120, width: 160, height: 80)
        progressBar.barColor = .systemOrange
        progressBar.backgroundBarColor = .systemGray5
        progressBar.lineWidth = 14
        progressBar.startAngle = 180
        progressBar.endAngle = 360
        progressBar.animationType = .simple
        progressBar.animationDuration = 1.0
        progressBar.setProgress(progress, animated: false)
        view.addSubview(progressBar)

        // Button to increase progress
        button.setTitle("Increase Progress", for: .normal)
        button.frame = CGRect(x: 40, y: 220, width: 160, height: 44)
        button.addTarget(self, action: #selector(increaseProgress), for: .touchUpInside)
        view.addSubview(button)

        // Forward-backward animated arc progress bar
        forwardBackwardBar.frame = CGRect(x: 220, y: 120, width: 140, height: 140)
        forwardBackwardBar.barColor = .systemGreen
        forwardBackwardBar.backgroundBarColor = .systemGray6
        forwardBackwardBar.lineWidth = 10
        forwardBackwardBar.startAngle = 0
        forwardBackwardBar.endAngle = 270
        forwardBackwardBar.animationType = .forwardBackward
        forwardBackwardBar.animationDuration = 1.5
        forwardBackwardBar.setProgress(progress, animated: false)
        view.addSubview(forwardBackwardBar)

        // Gradient arc progress bar
        let gradientBar = ArcProgressView()
        gradientBar.frame = CGRect(x: 120, y: 260, width: 180, height: 180)
        gradientBar.gradientColors = [.systemRed, .systemYellow, .systemOrange, .systemPurple]
        gradientBar.backgroundBarColor = .systemGray4
        gradientBar.lineWidth = 16
        gradientBar.startAngle = 90
        gradientBar.endAngle = 270
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