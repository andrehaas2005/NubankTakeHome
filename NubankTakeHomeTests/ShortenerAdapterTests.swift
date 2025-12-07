import XCTest
@testable import NubankTakeHome
import Core

@MainActor
final class ShortenerAdapterTests: XCTestCase {
  
  private var sut: ShortenerAdapter!
  
  override func setUp() {
    super.setUp()
    sut = ShortenerAdapter()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - EMPTY INPUT
  
  func test_toUIModels_emptyList_returnsEmpty() {
    let result = sut.toUIModels([])
    XCTAssertTrue(result.isEmpty)
  }
  
  // MARK: - SINGLE ITEM
  
  func test_toUIModels_mapsSingleItemCorrectly() {
    let alias = AliasResponse.fixed()
    
    let ui = sut.toUIModels([alias])
    
    XCTAssertEqual(ui.count, 1)
    XCTAssertEqual(ui.first?.alias, "abc123")
    XCTAssertEqual(ui.first?.shortURL, "https://short.com")
    XCTAssertEqual(ui.first?.originalURL, "https://full.com")
  }
  
  // MARK: - MULTIPLE ITEMS
  
  func test_toUIModels_mapsMultipleItemsInOrder() {
    let a1 = AliasResponse(alias: "1", links: .init(self: "a", short: "b"))
    let a2 = AliasResponse(alias: "2", links: .init(self: "c", short: "d"))
    
    let ui = sut.toUIModels([a1, a2])
    
    XCTAssertEqual(ui.count, 2)
    XCTAssertEqual(ui[0].alias, "1")
    XCTAssertEqual(ui[1].alias, "2")
  }
}
