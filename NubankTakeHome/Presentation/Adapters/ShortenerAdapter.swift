import Foundation
import Core

public struct ShortenerUIModel: Hashable {
  public let id = UUID()
  public let alias: String
  public let shortURL: String
  public let originalURL: String
}

public protocol ShortenerAdapterProtocol {
  func toUIModels(_ list: [AliasResponse]) -> [ShortenerUIModel]
}

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
