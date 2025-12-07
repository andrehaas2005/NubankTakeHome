import XCTest
import SnapshotTesting
@testable import NubankTakeHome
import Core
import Networking

final class ShortenerViewControllerSnapshotTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  // MARK: - Helpers
  
  @MainActor private func makeSUT(
    links: [AliasResponse] = [],
    isLoading: Bool = false,
    error: String? = nil,
    router: ShortenerRouting = ShortenerRoutingMock()
  ) -> ShortenerViewController {
    
    let engine = ShortenerEngineMock()
    let repo   = LinkRepositoryMock()
    let adapter = ShortenerAdapter()
    if ((error?.isEmpty) == nil) {
      engine.mode = .failure(CoreError.invalidInput("\(String(describing: error))"))
    }
    repo.initial = links
    
    let vm = ShortenerViewModel(
      engine: engine,
      repository: repo,
      adapter: adapter
    )
    
    return ShortenerViewController(viewModel: vm, router: router)
  }
  
  // MARK: - Tests
  
  @MainActor func test_snapshot_emptyState() {
    let sut = makeSUT(links: [])
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
  
  @MainActor func test_snapshot_withItems() {
    let alias = AliasResponse(
      alias: "abc123",
      links: .init(self: "https://full.com", short: "https://short.com")
    )
    let alias2 = AliasResponse(
      alias: "xyz999",
      links: .init(self: "https://apple.com", short: "https://a.co/x9")
    )
    
    let sut = makeSUT(links: [alias, alias2])
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
  
  @MainActor func test_snapshot_loadingState() {
    let sut = makeSUT(isLoading: true)
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
  
  @MainActor func test_snapshot_withErrorPresented() {
    let navigation = UINavigationController()
    let sut = makeSUT(error: "Algo deu errado...", router: ShortenerRouter(navigationController: navigation))
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    // Para capturar o alerta, precisamos apresentá-lo manualmente
    sut.loadViewIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
}

