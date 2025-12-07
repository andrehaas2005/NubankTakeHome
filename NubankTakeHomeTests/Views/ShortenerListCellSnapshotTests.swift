//
//  ShortenerListCellSnapshotTests.swift
//  NubankTakeHome
//
//  Created by Andre  Haas on 06/12/25.
//


import XCTest
@testable import NubankTakeHome
import Core

final class ShortenerListCellSnapshotTests: XCTestCase {

    func test_listCell_populated() {
        let cell = ShortenerListCell(style: .default, reuseIdentifier: "ShortenerListCell")

        let model = AliasResponse(
            alias: "abc123",
            links: .init(self: "https://full.com", short: "https://short.com")
        )

        cell.frame = CGRect(x: 0, y: 0, width: 375, height: 84)
        cell.configure(with: model)

        SnapshotConfig.assertSnapshot(view: cell)
    }
}
