//
//  ShortenerHeaderViewSnapshotTests.swift
//  NubankTakeHome
//
//  Created by Andre  Haas on 06/12/25.
//


import XCTest
@testable import NubankTakeHome

final class ShortenerHeaderViewSnapshotTests: XCTestCase {

    func test_header_default() {
        let view = ShortenerHeaderView(frame: .init(x: 0, y: 0, width: 375, height: 120))
        SnapshotConfig.assertSnapshot(view: view)
    }

    func test_header_customized() {
        let view = ShortenerHeaderView(frame: .init(x: 0, y: 0, width: 375, height: 120))
        view.configure(title: "Custom Title", subtitle: "Custom subtitle text")
        SnapshotConfig.assertSnapshot(view: view)
    }
}
