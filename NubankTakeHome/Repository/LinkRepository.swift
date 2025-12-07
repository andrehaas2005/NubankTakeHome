import Foundation
import Core

/// Protocolo para permitir substituição por outro tipo de storage
/// (UserDefaults, SQLite, Realm, CoreData, FileCache, etc.)
public protocol LinkRepositoryProcotol {
  func save(_ alias: AliasResponse)
  func all() -> [AliasResponse]
  func clear()
}

/// Versão simples em memória.
/// Ideal para testes e protótipos.
public final class InMemoryLinkRepository: LinkRepositoryProcotol {
  
  private var storage: [AliasResponse] = []
  
  public init() {}
  
  public func save(_ alias: AliasResponse) {
    // insere sempre no topo (mais recente primeiro)
    storage.insert(alias, at: 0)
  }
  
  public func all() -> [AliasResponse] {
    storage
  }
  
  public func clear() {
    storage.removeAll()
  }
}
