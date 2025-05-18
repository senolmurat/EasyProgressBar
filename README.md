# EasyProgressBar

**EasyProgressBar** is a flexible and lightweight SwiftUI package for beautiful, animated progress bars in your iOS apps. It supports horizontal, vertical, circular, and arc-based indicators, with full customization and native support for SwiftUI.


![Horizontal-Vertical](https://github.com/senolmurat/EasyProgressBar/blob/main/assets/horizontal_vertical.gif)
![Circular](https://github.com/senolmurat/EasyProgressBar/blob/main/assets/circular.gif)
![Arc](https://github.com/senolmurat/EasyProgressBar/blob/main/assets/arc.gif)

---

## 🚀 Features

- Multiple shapes: **Horizontal**, **Vertical**, **Circular**, **Arc**
- Solid and gradient fills
- Customizable line width and line caps (`butt`, `round`, `square`)
- Forward-backward and standard animations
- Shadow and glow effects
- Modular: use only what you need
- Native **SwiftUI** support
- Simple, intuitive API
- Fully customizable with SwiftUI modifiers

---

## 📦 Installation

### Swift Package Manager (SPM)

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL:
   ```
   https://github.com/senolmurat/EasyProgressBar.git
   ```
3. Add the package to your target.

Or add to your `Package.swift`:

```swift
.package(url: "https://github.com/senolmurat/EasyProgressBar.git", from: "1.0.0")
```

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

---

## 🔗 Integration Flow

### SwiftUI
1. Import `EasyProgressBar` in your view.
2. Add the desired progress bar view, binding to a `@State` progress variable.
3. Customize with modifiers for color, width, animation, etc.

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
| `glowColor`           | Glow color for the progress bar              | All                  |
| `glowRadius`          | Glow blur radius                             | All                  |

---

## 🤝 Contributing
Feel free to submit pull requests or open issues to suggest features and report bugs.

## 📄 License

This project is licensed under the [MIT License](LICENSE.txt). 
