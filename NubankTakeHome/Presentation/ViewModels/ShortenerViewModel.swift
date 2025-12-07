import Foundation
import Combine
import Core
import Networking

@MainActor
final class ShortenerViewModel: ObservableObject {
  
  // MARK: - Dependencies
  private let engine: ShortenerEngineProtocol
  private let repository: LinkRepositoryProcotol
  private let adapter: ShortenerAdapterProtocol
  
  // MARK: - Published outputs
  @Published private(set) var links: [AliasResponse] = []
  @Published private(set) var uiModels: [ShortenerUIModel] = []
  @Published private(set) var isLoading: Bool = false
  @Published private(set) var errorMessage: String?
  
  // MARK: - Init
  init(
    engine: ShortenerEngineProtocol,
    repository: LinkRepositoryProcotol,
    adapter: ShortenerAdapterProtocol
  ) {
    self.engine = engine
    self.repository = repository
    self.adapter = adapter
    
    // carrega links armazenados no início
    self.links = repository.all()
    self.uiModels = adapter.toUIModels(self.links)
  }
  
  // MARK: - Public API
  func shorten(_ url: String) async {
    errorMessage = nil
    
    guard Validators.isValidURL(url) else {
      errorMessage = "URL inválida"
      return
    }
    
    isLoading = true
    defer { isLoading = false }
    
    do {
      let response = try await engine.shorten(url)
      
      // salva no repositório
      repository.save(response)
      
      // atualiza estados
      refresh()
      
    } catch {
      handleEngineError(error)
    }
  }
  
  /// Carrega novamente a lista do Repositório
  func refresh() {
    self.links = repository.all()
    self.uiModels = adapter.toUIModels(self.links)
  }
  
  func clearError() {
    errorMessage = nil
  }
  
  // MARK: - Error Handling
  private func handleEngineError(_ error: Error) {
    switch error {
    case let net as NetworkError:
      switch net {
      case .httpError(let code):
        errorMessage = "Erro HTTP (\(code))"
      case .decodingFailed:
        errorMessage = "Erro ao interpretar dados do servidor."
      case .invalidURL:
        errorMessage = "URL inválida."
      default:
        errorMessage = "Erro de rede. Tente novamente."
      }
      
    case let core as CoreError:
      errorMessage = core.localizedDescription
      
    default:
      errorMessage = "Erro inesperado. Tente novamente."
    }
  }
}
