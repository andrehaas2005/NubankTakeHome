import XCTest
@testable import Networking
@testable import Core
@testable import NubankTakeHome

final class LinkServiceTests: XCTestCase {
  
  private var client: NetworkClientMock!
  private var sut: LinkService!
  
  override func setUp() {
    super.setUp()
    client = NetworkClientMock()
    sut = LinkService(client: client)
  }
  
  override func tearDown() {
    client = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - shorten()
  
  func test_shorten_success() async throws {
    let expected = AliasResponse.fixed()

    client.mode = .success(expected)
    
    let result = try await sut.shorten(url: "https://apple.com")
    
    XCTAssertEqual(result.alias, expected.alias)
    XCTAssertEqual(client.lastEndpoint, .shorten)
    
    let body = client.lastBody as? Body
    XCTAssertEqual(body?.url, "https://apple.com")
  }
  
  func test_shorten_failure() async {
    client.mode = .failure(NetworkError.httpError(500))
    
    do {
      _ = try await sut.shorten(url: "https://apple.com")
      XCTFail("Expected error not thrown")
    } catch {
      XCTAssertTrue(error is NetworkError)
    }
  }
  
  // MARK: - fetchOriginalURL()
  
  func test_fetchOriginal_success() async throws {
    let expected = UrlResponse(url: "https://full.com")
    client.mode = .success(expected)
    
    let result = try await sut.fetchOriginalURL(alias: "abc123")
    
    XCTAssertEqual(result.url, expected.url)
    XCTAssertEqual(client.lastEndpoint, .original("abc123"))
  }
  
  func test_fetchOriginal_failure() async {
    client.mode = .failure(NetworkError.unknown)
    
    do {
      _ = try await sut.fetchOriginalURL(alias: "abc123")
      XCTFail("Expected error not thrown")
    } catch {
      XCTAssertTrue(error is NetworkError)
    }
  }
}
