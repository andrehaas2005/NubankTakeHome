import XCTest
@testable import NubankTakeHome
import Core
import Networking

@MainActor
final class ShortenerEngineTests: XCTestCase {
  
  private var service: LinkServiceMock!
  private var sut: ShortenerEngine!
  
  private let alias = AliasResponse.fixed()
  
  // MARK: Setup
  
  override func setUp() {
    super.setUp()
    service = LinkServiceMock()
    sut = ShortenerEngine(service: service)
  }
  
  override func tearDown() {
    service = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - NORMALIZATION
  
  func test_shorten_addsHTTPS_ifMissing() async throws {
    service.result = .success(alias)
    
    _ = try await sut.shorten("google.com")
    
    XCTAssertEqual(service.lastURL, "https://google.com")
  }
  
  func test_shorten_keepsHTTP_whenPresent() async throws {
    service.result = .success(alias)
    
    _ = try await sut.shorten("http://apple.com")
    
    XCTAssertEqual(service.lastURL, "http://apple.com")
  }
  
  func test_shorten_keepsHTTPS_whenPresent() async throws {
    service.result = .success(alias)
    
    _ = try await sut.shorten("https://uol.com")
    
    XCTAssertEqual(service.lastURL, "https://uol.com")
  }
  
  // MARK: - SUCCESS
  
  func test_shorten_success_returnsResponse() async throws {
    service.result = .success(alias)
    
    let result = try await sut.shorten("https://ok.com")
    
    XCTAssertEqual(result.alias, "abc123")
    XCTAssertEqual(result.links.short, "https://short.com")
  }
  
  // MARK: - ERROR FORWARDING
  
  func test_shorten_forwardsNetworkError() async {
    service.result = .failure(NetworkError.decodingFailed)
    
    do {
      _ = try await sut.shorten("https://error.com")
      XCTFail("Expected error")
    } catch {
      XCTAssertTrue(error is NetworkError)
    }
  }
  
  func test_shorten_forwardsCoreError() async {
    service.result = .failure(CoreError.unknown)
    
    do {
      _ = try await sut.shorten("https://error.com")
      XCTFail("Expected error")
    } catch {
      XCTAssertTrue(error is CoreError)
    }
  }
}
