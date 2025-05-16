import UIKit
import EasyProgressBar

class HorizontalProgressBarUIKitExampleViewController: UIViewController {
    let progressBar = HorizontalProgressView()
    let forwardBackwardBar = HorizontalProgressView()
    let button = UIButton(type: .system)
    var progress: CGFloat = 0.3

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Simple animated progress bar
        progressBar.frame = CGRect(x: 40, y: 120, width: 300, height: 20)
        progressBar.barColor = .systemBlue
        progressBar.backgroundBarColor = .systemGray5
        progressBar.lineWidth = 12
        progressBar.animationType = .simple
        progressBar.animationDuration = 1.0
        progressBar.setProgress(progress, animated: false)
        view.addSubview(progressBar)

        // Button to increase progress
        button.setTitle("Increase Progress", for: .normal)
        button.frame = CGRect(x: 40, y: 160, width: 300, height: 44)
        button.addTarget(self, action: #selector(increaseProgress), for: .touchUpInside)
        view.addSubview(button)

        // Forward-backward animated progress bar
        forwardBackwardBar.frame = CGRect(x: 40, y: 220, width: 300, height: 20)
        forwardBackwardBar.barColor = .systemGreen
        forwardBackwardBar.backgroundBarColor = .systemGray6
        forwardBackwardBar.lineWidth = 10
        forwardBackwardBar.animationType = .forwardBackward
        forwardBackwardBar.animationDuration = 1.5
        forwardBackwardBar.setProgress(progress, animated: false)
        view.addSubview(forwardBackwardBar)
    }

    @objc func increaseProgress() {
        progress = min(progress + 0.2, 1.0)
        progressBar.setProgress(progress, animated: true)
        // forwardBackwardBar is animating independently
    }
} 