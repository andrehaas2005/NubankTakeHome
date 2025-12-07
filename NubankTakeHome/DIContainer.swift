import UIKit
import Core
import Networking

/// DIContainer: montagem central de dependências do App.
/// Mantemos tipos por protocolo onde possível para facilitar testes e substituições.
final class DIContainer {
  
  // MARK: - Configuration
  private let baseURLString: String
  private lazy var baseURL: URL = {
    URL(string: baseURLString)!
  }()
  
  // MARK: - Init
  init(baseURLString: String = "https://url-shortener-server.onrender.com") {
    self.baseURLString = baseURLString
  }
  
  // MARK: - Networking
  func makeNetworkClient() -> NetworkClientProtocol {
    NetworkClient(baseURL: baseURL)
  }
  
  // MARK: - Services
  func makeLinkService() -> LinkServiceProtocol {
    LinkService(client: makeNetworkClient())
  }
  
  // MARK: - Repository
  func makeRepository() -> LinkRepositoryProcotol {
    InMemoryLinkRepository()
  }
  
  // MARK: - ViewModels
  func makeShortenerViewModel() -> ShortenerViewModel {
    ShortenerViewModel(
      engine: makeShortenerEngine(),
      repository: makeRepository(),
      adapter: makeShortenerAdapter()
    )
  }
  
  // MARK: - Engine / Adapter
  func makeShortenerEngine() -> ShortenerEngine {
    ShortenerEngine(service: makeLinkService())
  }
  
  func makeShortenerAdapter() -> ShortenerAdapterProtocol {
    ShortenerAdapter()
  }
  
  // MARK: - Builders
  func makeShortenerViewController(router: ShortenerRouter) -> UIViewController {
    let vm = makeShortenerViewModel()
    let vc = ShortenerViewController(viewModel: vm)
    return vc
  }
}
