import Foundation
import Core

public protocol ShortenerEngineProtocol {
  func shorten(_ url: String) async throws -> AliasResponse
}

public final class ShortenerEngine: ShortenerEngineProtocol {
  
  private let service: LinkServiceProtocol
  
  public init(service: LinkServiceProtocol) {
    self.service = service
  }
  
  public func shorten(_ url: String) async throws -> AliasResponse {
    let normalized = normalize(url)
    return try await service.shorten(url: normalized)
  }
  
  // MARK: - Helpers
  
  private func normalize(_ text: String) -> String {
    var url = text.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if !url.lowercased().hasPrefix("http") {
      url = "https://\(url)"
    }
    
    return url
  }
}
