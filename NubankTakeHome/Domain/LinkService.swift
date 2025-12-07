import Foundation
import Core
import Networking

public protocol LinkServiceProtocol {
  func shorten(url: String) async throws -> AliasResponse
  func fetchOriginalURL(alias: String) async throws -> UrlResponse
}

/// Implementação concreta do serviço.
/// Ele apenas orquestra chamadas para o módulo Networking.
/// Toda validação, normalização e regras extras ficam na Engine.
final class LinkService: LinkServiceProtocol {
  
  private let client: NetworkClientProtocol
  
  init(client: NetworkClientProtocol) {
    self.client = client
  }
  
  // POST /api/alias
  func shorten(url: String) async throws -> AliasResponse {
    struct Body: Encodable {
      let url: String
    }
    
    let body = Body(url: url)
    return try await client.post("/api/alias", body: body)
  }
  
  // GET /api/alias/{alias}
  func fetchOriginalURL(alias: String) async throws -> UrlResponse {
    try await client.get("/api/alias/\(alias)")
  }
}
