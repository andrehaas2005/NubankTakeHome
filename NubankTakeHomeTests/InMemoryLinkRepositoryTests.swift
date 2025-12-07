import XCTest
@testable import NubankTakeHome
import Core

@MainActor
final class InMemoryLinkRepositoryTests: XCTestCase {
  
  private var sut: InMemoryLinkRepository!
  private let alias = AliasResponse.fixed()
  
  override func setUp() {
    super.setUp()
    sut = InMemoryLinkRepository()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - EMPTY STATE
  
  func test_initial_allIsEmpty() {
    XCTAssertTrue(sut.all().isEmpty)
  }
  
  // MARK: - SAVE
  
  func test_save_insertsItemAtTop() {
    sut.save(alias)
    
    let result = sut.all()
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first?.alias, "abc123")
  }
  
  func test_multiple_saves_keepLatestOnTop() {
    let alias2 = AliasResponse(
      alias: "xyz789",
      links: .init(self: "a", short: "b")
    )
    
    sut.save(alias)    // first
    sut.save(alias2)   // second
    
    let list = sut.all()
    
    // alias2 must be first
    XCTAssertEqual(list.first?.alias, "xyz789")
    // alias must be second
    XCTAssertEqual(list.last?.alias, "abc123")
  }
  
  // MARK: - CLEAR
  
  func test_clear_removesAllItems() {
    sut.save(alias)
    XCTAssertEqual(sut.all().count, 1)
    
    sut.clear()
    XCTAssertTrue(sut.all().isEmpty)
  }
}
