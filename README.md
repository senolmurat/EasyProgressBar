# EasyProgressBar

**EasyProgressBar** is a flexible and lightweight SwiftUI package for beautiful, animated progress bars in your iOS apps. It supports horizontal, vertical, circular, and arc-based indicators, with full customization and native support for SwiftUI.

<img src="https://github.com/senolmurat/EasyProgressBar/blob/main/assets/horizontal_vertical.gif" width="236" height="430" /> <img src="https://github.com/senolmurat/EasyProgressBar/blob/main/assets/circular.gif" width="236" height="430" /> <img src="https://github.com/senolmurat/EasyProgressBar/blob/main/assets/arc.gif" width="236" height="430" />

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

### SwiftUI - 🧩 Unified Progress Bar Usage

You can use the `EasyProgressBar` view to create any supported progress bar style by simply changing the `barStyle` parameter:

```swift
import SwiftUI
import EasyProgressBar

struct ContentView: View {
    @State private var progress: CGFloat = 0.7
    @State private var style: ProgressBarStyle = .horizontal

    var body: some View {
        VStack(spacing: 32) {
            Picker("Style", selection: $style) {
                Text("Horizontal").tag(ProgressBarStyle.horizontal)
                Text("Vertical").tag(ProgressBarStyle.vertical)
                Text("Circular").tag(ProgressBarStyle.circular)
                Text("Arc").tag(ProgressBarStyle.arc)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            EasyProgressBar(
                progress: $progress,
                barStyle: style,
                barColor: .blue,
                backgroundColor: .gray.opacity(0.2),
                lineWidth: 12,
                animationType: .simple,
                animationDuration: 1.0,
                foregroundGradient: [.blue, .purple],
                startAngle: .degrees(180), // Only used for .arc
                endAngle: .degrees(360)    // Only used for .arc
            )
            .frame(height: style == .horizontal ? 24 : 200)
            .frame(width: style == .vertical ? 24 : 200)

            Slider(value: $progress, in: 0...1)
                .padding()
        }
    }
}
```

- Change the `barStyle` to switch between horizontal, vertical, circular, and arc progress bars.
- All customization options are available through the unified initializer.

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
