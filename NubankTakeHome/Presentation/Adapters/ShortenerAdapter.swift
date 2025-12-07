import Foundation
import Core

/// Modelo preparado para exibição na UI.
/// Pode conter formatações, textos amigáveis, conversões, etc.
public struct ShortenerUIModel: Hashable {
  public let id = UUID()
  public let alias: String
  public let shortURL: String
  public let originalURL: String
}

/// Protocolo para permitir mocks em testes
public protocol ShortenerAdapterProtocol {
  func toUIModels(_ list: [AliasResponse]) -> [ShortenerUIModel]
}

/// Adapter responsável por transformar modelos do Core em modelos da UI.
public final class ShortenerAdapter: ShortenerAdapterProtocol {
  
  public init() {}
  
  public func toUIModels(_ list: [AliasResponse]) -> [ShortenerUIModel] {
    list.map {
      ShortenerUIModel(
        alias: $0.alias,
        shortURL: $0.links.short,
        originalURL: $0.links.`self`
      )
    }
  }
}
