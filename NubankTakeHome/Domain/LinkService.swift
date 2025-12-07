import Foundation
import Core
import Networking

public protocol LinkServiceProtocol {
  func shorten(url: String) async throws -> AliasResponse
  func fetchOriginalURL(alias: String) async throws -> UrlResponse
}
struct Body: Encodable { let url: String }
final class LinkService: LinkServiceProtocol {
  
  private let client: NetworkClientProtocol
  
  init(client: NetworkClientProtocol) {
    self.client = client
  }
  
  func shorten(url: String) async throws -> AliasResponse {
    try await client.post(.shorten, body: Body(url: url))
  }
  
  func fetchOriginalURL(alias: String) async throws -> UrlResponse {
    try await client.get(.original(alias))
  }
}
