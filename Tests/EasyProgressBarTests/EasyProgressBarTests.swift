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
        let bar = HorizontalProgressBar(progress: .constant(0))
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testVerticalProgressViewInitialization() {
        let bar = VerticalProgressBar(progress: .constant(0))
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testCircularProgressViewInitialization() {
        let bar = CircularProgressBar(progress: .constant(0))
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testArcProgressViewInitialization() {
        let bar = ArcProgressBar(progress: .constant(0))
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testSetProgress() {
        let bar = HorizontalProgressBar(progress: .constant(0))
        bar.progress = 0.7
        XCTAssertEqual(bar.progress, 0.7)
    }

    func testBarColorChange() {
        var bar = HorizontalProgressBar(progress: .constant(0))
        bar.barColor = .red
        XCTAssertEqual(bar.barColor, .red)
    }
}
