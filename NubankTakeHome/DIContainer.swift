import UIKit
import Core
import Networking

final class DIContainer {

    private let env: AppEnvironment

    init(env: AppEnvironment = .prod) {
        self.env = env
    }

    func makeNetworkClient() -> NetworkClientProtocol {
        NetworkClient(
            baseURL: env.baseURL,
            session: .shared
        )
    }

    func makeLinkService() -> LinkServiceProtocol {
        LinkService(client: makeNetworkClient())
    }

    func makeRepository() -> LinkRepositoryProcotol {
        InMemoryLinkRepository()
    }

    func makeShortenerEngine() -> ShortenerEngineProtocol {
        ShortenerEngine(service: makeLinkService())
    }

    func makeShortenerAdapter() -> ShortenerAdapterProtocol {
        ShortenerAdapter()
    }

    func makeShortenerViewModel() -> ShortenerViewModel {
        ShortenerViewModel(
            engine: makeShortenerEngine(),
            repository: makeRepository(),
            adapter: makeShortenerAdapter()
        )
    }

    func makeShortenerViewController(router: ShortenerRouter) -> UIViewController {
        ShortenerViewController(viewModel: makeShortenerViewModel())
    }
}
