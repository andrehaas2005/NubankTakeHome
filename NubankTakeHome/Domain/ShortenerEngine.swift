import Foundation
import Core

/// Protocolo para permitir mocks em testes
public protocol ShortenerEngineProtocol {
  func shorten(_ url: String) async throws -> AliasResponse
}

/// Engine: camada de REGRAS DE NEGÓCIO.
/// Aqui fazemos:
/// - normalização da URL
/// - validações adicionais
/// - tratamento de erros do service
/// - preparação de dados
/// - logs, analytics (se quiser)
public final class ShortenerEngine: ShortenerEngineProtocol {
  
  private let service: LinkServiceProtocol
  
  public init(service: LinkServiceProtocol) {
    self.service = service
  }
  
  /// Normaliza, valida e chama o service
  public func shorten(_ url: String) async throws -> AliasResponse {
    let normalized = normalize(url)
    return try await service.shorten(url: normalized)
  }
  
  // MARK: - Helpers
  
  /// Adiciona https:// se faltar
  private func normalize(_ text: String) -> String {
    var url = text.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if !url.lowercased().hasPrefix("http") {
      url = "https://\(url)"
    }
    
    return url
  }
}
