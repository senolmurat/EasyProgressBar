# EasyProgressBar

**EasyProgressBar** is a flexible and lightweight SwiftUI package for beautiful, animated progress bars in your iOS apps. It supports horizontal, vertical, circular, and arc-based indicators, with full customization and native support for SwiftUI.

<img src="https://github.com/senolmurat/EasyProgressBar/blob/main/assets/horizontal_vertical.gif" width="236" height="430" /> <img src="https://github.com/senolmurat/EasyProgressBar/blob/main/assets/circular.gif" width="236" height="430" /> <img src="https://github.com/senolmurat/EasyProgressBar/blob/main/assets/arc.gif" width="236" height="430" />

---

## 🚀 Features

- Multiple shapes: **Horizontal**, **Vertical**, **Circular**, **Arc**
- Solid and gradient fills
- Customizable line width and line caps (`butt`, `round`, `square`)
- Forward-backward and standard animations
- Label & Content Support
- Shadow and glow effects
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
            // Minimal horizontal
            EasyProgressBar(progress: $progress)
                .barStyle(.horizontal)
                .padding()

            // Fully customized circular
            EasyProgressBar(progress: $progress, content: {
                Text("test")
            })
                .barStyle(.circular)
                .barColor(.purple)
                .backColor(.gray.opacity(0.2))
                .lineWidth(12)
                .barGradientColors([.purple, .pink, .purple])
                .animationType(.forwardBackward(duration: 1.5))
                .shadow(color: .pink, radius: 12)
                .frame(width: 100, height: 100)

            // Arc
            EasyProgressBar(progress: $progress)
                .barStyle(.arc)
                .barColor(.orange)
                .backColor(.gray.opacity(0.2))
                .lineWidth(14)
                .startAngle(.degrees(180))
                .endAngle(.degrees(360))
                .animationType(.simple(duration: 1.0))
                .frame(width: 160, height: 80)

            // Vertical with gradient
            EasyProgressBar(progress: $progress)
                .barStyle(.vertical)
                .barGradientColors([.purple, .pink, .orange])
                .backColor(.gray.opacity(0.15))
                .lineWidth(24)
                .animationType(.simple(duration: 1.0))
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
| `barStyle`            | `.horizontal`, `.verticle`, `.circle`, `.arc`| All                  |
| `barColor`            | Solid color for the progress bar             | All                  |
| `backColor`           | Background color of the track                | All                  |
| `lineWidth`           | Thickness of the progress bar                | All                  |
| `lineCap`             | Shape of bar end: `.butt`, `.round`, `.square` | All               |
| `barGradientColors`   | Gradient for progress fill                   | ALL                  |
| `animationType`       | `.none`, `.simple`, `.forwardBackward`       | All                  |
| `startAngle`/`endAngle` | For arc-based rendering                    | Arc only             |

---

## 🤝 Contributing
Feel free to submit pull requests or open issues to suggest features and report bugs.

## 📄 License

This project is licensed under the [MIT License](LICENSE.txt). 
