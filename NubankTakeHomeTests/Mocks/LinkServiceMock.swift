import Core
@testable import NubankTakeHome
final class LinkServiceMock: LinkServiceProtocol {
  
  var result: Result<AliasResponse, Error> = .failure(CoreError.unknown)
  private(set) var lastURL: String?
  
  func shorten(url: String) async throws -> AliasResponse {
    lastURL = url
    return try result.get()
  }
  
  func fetchOriginalURL(alias: String) async throws -> UrlResponse {
    fatalError("Not used in tests")
  }
}
