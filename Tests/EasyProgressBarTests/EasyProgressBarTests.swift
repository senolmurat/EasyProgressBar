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
        let bar = EasyProgressBar(progress: .constant(0), barStyle: .horizontal)
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testVerticalProgressViewInitialization() {
        let bar = EasyProgressBar(progress: .constant(0), barStyle: .horizontal)
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testCircularProgressViewInitialization() {
        let bar = EasyProgressBar(progress: .constant(0), barStyle: .horizontal)
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testArcProgressViewInitialization() {
        let bar = EasyProgressBar(progress: .constant(0), barStyle: .horizontal)
        XCTAssertEqual(bar.progress, 0.0)
        XCTAssertEqual(bar.barColor, .blue)
        XCTAssertEqual(bar.backgroundColor, .gray.opacity(0.2))
        XCTAssertEqual(bar.lineWidth, 8)
    }

    func testSetProgress() {
        let bar = EasyProgressBar(progress: .constant(0), barStyle: .horizontal)
        bar.progress = 0.7
        XCTAssertEqual(bar.progress, 0.7)
    }

    func testBarColorChange() {
        var bar = EasyProgressBar(progress: .constant(0), barStyle: .horizontal)
        bar.barColor = .red
        XCTAssertEqual(bar.barColor, .red)
    }
}
