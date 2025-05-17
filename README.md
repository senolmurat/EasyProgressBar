# EasyProgressBar

**EasyProgressBar** is a flexible and lightweight Swift/SwiftUI package for beautiful, animated progress bars in your iOS apps. It supports horizontal, vertical, circular, and arc-based indicators, with full customization and native support for both SwiftUI and UIKit.

---

## 🚀 Features

- Multiple shapes: **Horizontal**, **Vertical**, **Circular**, **Arc**
- Solid and gradient fills
- Customizable line width and line caps (`butt`, `round`, `square`)
- Forward-backward and standard animations
- Shadow and glow effects
- Modular: use only what you need
- Native **SwiftUI** and **UIKit** support
- Simple, intuitive API
- Fully customizable with `@IBDesignable` (UIKit) and SwiftUI modifiers

---

## 📦 Installation

### Swift Package Manager (SPM)

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL:
   ```
   https://github.com/yourusername/EasyProgressBar.git
   ```
3. Add the package to your target.

Or add to your `Package.swift`:

```swift
.package(url: "https://github.com/yourusername/EasyProgressBar.git", from: "1.0.0")
```

---

## 🧩 Components Overview

- `HorizontalProgressBar` (SwiftUI)  / `HorizontalProgressView` (UIKit)
- `VerticalProgressBar`   (SwiftUI)  / `VerticalProgressView`   (UIKit)
- `CircularProgressBar`   (SwiftUI)  / `CircularProgressView`   (UIKit)
- `ArcProgressBar`        (SwiftUI)  / `ArcProgressView`        (UIKit)

---

## 🛠 Usage Examples

### SwiftUI

```swift
import EasyProgressBar
import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0.6

    var body: some View {
        VStack(spacing: 32) {
            // Horizontal
            HorizontalProgressBar(progress: $progress)
                .barColor(.blue)
                .backgroundColor(.gray.opacity(0.2))
                .lineWidth(10)
                .animationType(.simple)
                .animationDuration(1.0)
                .foregroundGradient([.blue, .cyan])
                .barShadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 2)
                .barGlow(color: .blue, radius: 12)
                .padding()

            // Circular
            CircularProgressBar(progress: $progress)
                .lineWidth(12)
                .foregroundGradient([.purple, .pink])
                .animationType(.forwardBackward)
                .frame(width: 100, height: 100)

            // Arc
            ArcProgressBar(progress: $progress)
                .barColor(.orange)
                .backgroundColor(.gray.opacity(0.2))
                .lineWidth(14)
                .startAngle(.degrees(180))
                .endAngle(.degrees(360))
                .animationType(.simple)
                .frame(width: 160, height: 80)

            // Vertical
            VerticalProgressBar(progress: $progress)
                .foregroundGradient([.purple, .pink, .orange])
                .backgroundColor(.gray.opacity(0.15))
                .lineWidth(24)
                .animationType(.simple)
                .frame(width: 40, height: 200)
        }
    }
}
```

### UIKit

```swift
import EasyProgressBar

// Horizontal
let horizontalBar = HorizontalProgressView()
horizontalBar.frame = CGRect(x: 40, y: 100, width: 300, height: 20)
horizontalBar.progress = 0.7
horizontalBar.barColor = .systemBlue
horizontalBar.lineWidth = 10
horizontalBar.animationType = .simple
horizontalBar.animationDuration = 1.0
horizontalBar.shadowColor = .black
horizontalBar.shadowRadius = 6
horizontalBar.shadowOpacity = 0.3
horizontalBar.shadowOffset = CGSize(width: 0, height: 2)
horizontalBar.glowColor = .systemBlue
horizontalBar.glowRadius = 12
view.addSubview(horizontalBar)

// Circular
let circularBar = CircularProgressView()
circularBar.frame = CGRect(x: 40, y: 140, width: 100, height: 100)
circularBar.progress = 0.5
circularBar.gradientColors = [.systemPurple, .systemPink]
circularBar.lineWidth = 12
circularBar.animationType = .forwardBackward
view.addSubview(circularBar)

// Arc
let arcBar = ArcProgressView()
arcBar.frame = CGRect(x: 40, y: 260, width: 160, height: 80)
arcBar.progress = 0.6
arcBar.barColor = .systemOrange
arcBar.startAngle = 180
arcBar.endAngle = 360
arcBar.lineWidth = 14
arcBar.animationType = .simple
view.addSubview(arcBar)

// Vertical
let verticalBar = VerticalProgressView()
verticalBar.frame = CGRect(x: 220, y: 100, width: 40, height: 200)
verticalBar.progress = 0.8
verticalBar.gradientColors = [.systemPurple, .systemPink, .systemOrange]
verticalBar.lineWidth = 24
verticalBar.animationType = .simple
view.addSubview(verticalBar)
```

---

## 🔗 Integration Flow

### SwiftUI
1. Import `EasyProgressBar` in your view.
2. Add the desired progress bar view, binding to a `@State` progress variable.
3. Customize with modifiers for color, width, animation, etc.

### UIKit
1. Import `EasyProgressBar` in your view controller.
2. Create and configure the progress bar view.
3. Add it to your view hierarchy.
4. Update progress with `.setProgress(_:animated:)` as needed.

---

## 🎨 Customization Options

| Property              | Description                                  | Available In         |
|-----------------------|----------------------------------------------|----------------------|
| `progress`            | Current progress (0.0 to 1.0)                | All                  |
| `barColor`            | Solid color for the progress bar             | All                  |
| `backgroundColor`     | Background color of the track                | All                  |
| `lineWidth`           | Thickness of the progress bar                | All                  |
| `lineCap`             | Shape of bar end: `.butt`, `.round`, `.square` | All               |
| `foregroundGradient`  | Gradient for progress fill                   | ALL                  |
| `startAngle`/`endAngle` | For arc-based rendering                    | Arc only             |
| `animationType`       | `.none`, `.simple`, `.forwardBackward`       | All                  |
| `animationDuration`   | Duration of the animation                    | All                  |
| `shadowColor`         | Shadow color for the progress bar            | All                  |
| `shadowRadius`        | Shadow blur radius                           | All                  |
| `shadowOpacity`       | Shadow opacity (UIKit)                       | All (UIKit)          |
| `shadowOffset`        | Shadow offset (UIKit)                        | All (UIKit)          |
| `glowColor`           | Glow color for the progress bar              | All                  |
| `glowRadius`          | Glow blur radius                             | All                  |

---

## 🤝 Contributing
Feel free to submit pull requests or open issues to suggest features and report bugs.

## 📄 License

This project is licensed under the [MIT License](LICENSE.txt). 
