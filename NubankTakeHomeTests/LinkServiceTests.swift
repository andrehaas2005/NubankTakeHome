import XCTest
@testable import NubankTakeHome
import Networking
import Core

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
  
  // MARK: - Shorten
  
  func test_shorten_callsCorrectEndpoint_andSendsBody() async throws {
    // Prepare mock result
    let expected = AliasResponse(
      alias: "abc123",
      links: .init(self: "https://full.com", short: "https://short.com")
    )
    
    client.postResult = expected
    
    // Run
    let result = try await sut.shorten(url: "https://apple.com")
    
    // Verify
    XCTAssertEqual(result.alias, expected.alias)
    XCTAssertEqual(client.receivedPostPath, "/api/alias")
    
    // Body check
    guard let body = client.receivedPostBody else {
      return XCTFail("Body não recebido ou não convertido")
    }
    
    XCTAssertEqual(body["url"] as? String, "https://apple.com")
  }
  
  func test_shorten_propagatesError() async {
    client.postError = NetworkError.httpError(500)
    
    do {
      _ = try await sut.shorten(url: "https://apple.com")
      XCTFail("Deveria ter lançado erro")
    } catch {
      XCTAssertTrue(error is NetworkError)
    }
  }
  
  // MARK: - fetchOriginalURL
  
  func test_fetch_callsCorrectEndpoint_andReturnsDecoded() async throws {
    let expected = UrlResponse(url: "https://google.com")
    client.getResult = expected
    
    let result = try await sut.fetchOriginalURL(alias: "abc123")
    
    XCTAssertEqual(result.url, expected.url)
    XCTAssertEqual(client.receivedGetPath, "/api/alias/abc123")
  }
  
  func test_fetch_propagatesError() async {
    client.getError = NetworkError.invalidURL
    
    do {
      _ = try await sut.fetchOriginalURL(alias: "xyz")
      XCTFail("Era esperado erro")
    } catch {
      XCTAssertTrue(error is NetworkError)
    }
  }
}
