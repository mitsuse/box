import XCTest

@testable import Box

import Dispatch

final class LazyTests: XCTestCase {
    func testInitialize() {
        let value = 10
        let wrap = Lazy(Wrap(value))
        XCTAssertFalse(Wrap.isUsedAtLeastOnce)
        XCTAssertEqual(wrap.value.value, value)
        XCTAssertTrue(Wrap.isUsedAtLeastOnce)
    }

    func testExclusion() {
        let expectation = XCTestExpectation(description: "")
        let referenceQueue = DispatchQueue(label: "jp.mitsuse.BoxTests.LazyTests.reference", attributes: .concurrent)
        let assertionQueue = DispatchQueue(label: "jp.mitsuse.BoxTests.LazyTests.assertion")
        let repetition = 100
        let wrap = Lazy(Count())
        (0..<repetition).forEach { _ in referenceQueue.async { _ = wrap.value } }
        assertionQueue.async {
            Thread.sleep(forTimeInterval: 0.5)
            XCTAssertEqual(Count.value, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    final class Wrap {
        private(set) static var isUsedAtLeastOnce = false

        let value: Int

        init(_ value: Int) {
            self.value = value
            Wrap.isUsedAtLeastOnce = true
        }
    }

    final class Count {
        private(set) static var value: Int = 0

        init() {
            Count.value += 1
        }
    }
}
