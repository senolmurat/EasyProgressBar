import XCTest
@testable import EasyProgressBar

final class EasyProgressBarTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }

    func testHorizontalProgressViewInitialization() {
        let bar = HorizontalProgressView()
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .systemBlue)
        XCTAssertEqual(bar.backgroundBarColor, .systemGray5)
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testVerticalProgressViewInitialization() {
        let bar = VerticalProgressView()
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .systemBlue)
        XCTAssertEqual(bar.backgroundBarColor, .systemGray5)
        XCTAssertEqual(bar.lineWidth, 24)
    }

    func testCircularProgressViewInitialization() {
        let bar = CircularProgressView()
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .systemBlue)
        XCTAssertEqual(bar.backgroundBarColor, .systemGray5)
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testArcProgressViewInitialization() {
        let bar = ArcProgressView()
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .systemBlue)
        XCTAssertEqual(bar.backgroundBarColor, .systemGray5)
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testSetProgress() {
        let bar = HorizontalProgressView()
        bar.setProgress(0.7, animated: false)
        XCTAssertEqual(bar.progress, 0.7)
    }

    func testBarColorChange() {
        let bar = HorizontalProgressView()
        bar.barColor = .red
        XCTAssertEqual(bar.barColor, .red)
    }
}
