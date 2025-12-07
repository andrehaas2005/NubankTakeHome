import XCTest
@testable import NubankTakeHome
import Core
import Networking

@MainActor
final class ShortenerViewModelTests: XCTestCase {
  
  // Mocks
  private var engine: ShortenerEngineMock!
  private var repo: LinkRepositoryMock!
  private var adapter: ShortenerAdapterMock!
  private var sut: ShortenerViewModel!
  private let alias = AliasResponse.fixed()
  private let uiModel = ShortenerUIModel.fixed()
  // MARK: - Setup
  
  override func setUp() {
    super.setUp()
    
    engine  = ShortenerEngineMock()
    repo    = LinkRepositoryMock()
    adapter = ShortenerAdapterMock()
    
    // initial mock state
    repo.initial = [alias]
    adapter.ui   = [uiModel]
    
    sut = ShortenerViewModel(
      engine: engine,
      repository: repo,
      adapter: adapter
    )
  }
  
  override func tearDown() {
    engine = nil
    repo = nil
    adapter = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - INIT
  
  func test_init_loadsRepositoryLinks() {
    XCTAssertEqual(sut.links.count, 1)
    XCTAssertEqual(sut.links.first?.alias, "abc123")
  }
  
  func test_init_generatesUIModels() {
    XCTAssertEqual(sut.uiModels.count, 1)
    XCTAssertEqual(sut.uiModels.first?.alias, "abc123")
  }
  
  // MARK: - INVALID URL
  
  func test_shorten_invalidURL_setsError() async {
    await sut.shorten("invalid-url")
    XCTAssertEqual(sut.errorMessage, "URL inválida")
  }
  
  func test_shorten_invalidURL_setsError_with_clear_error() async {
    await sut.shorten("invalid-url")
    XCTAssertEqual(sut.errorMessage, "URL inválida")
    sut.clearError()
    XCTAssertNil(sut.errorMessage)
  }
  
  // MARK: - SUCCESS
  
  func test_shorten_success_savesToRepo_andUpdatesUI() async {
    engine.mode = .success(alias)
    await sut.shorten("https://ok.com")
    XCTAssertFalse(sut.isLoading)
    XCTAssertEqual(self.repo.saved.count, 1)
    XCTAssertEqual(sut.uiModels.first?.alias, "abc123")
  }
  
  // MARK: - ERROR HANDLING
  
  func test_error_decodingFailed() async {
    engine.mode = .failure(NetworkError.decodingFailed)
    await sut.shorten("https://ok.com")
    XCTAssertEqual(sut.errorMessage, "Erro ao interpretar dados do servidor.")
  }
  
  func test_error_httpError500() async {
    engine.mode = .failure(NetworkError.httpError(500))
    
    await sut.shorten("https://ok.com")
    XCTAssertEqual(sut.errorMessage, "Erro HTTP (500)")
  }
  
  func test_error_invalidURL() async {
    engine.mode = .failure(NetworkError.invalidURL)
    
    await sut.shorten("https://ok.com")
    XCTAssertEqual(sut.errorMessage, "URL inválida.")
  }
  
  func test_error_coreErrorUnknown() async {
    engine.mode = .failure(CoreError.unknown)
    await sut.shorten("https://ok.com")
    XCTAssertEqual(sut.errorMessage, "The operation couldn’t be completed. (Core.CoreError error 1.)")
  }
  
  func test_error_networkUnknown() async {
    engine.mode = .failure(NetworkError.unknown)
    await sut.shorten("https://ok.com")
    XCTAssertEqual(sut.errorMessage, "Erro de rede. Tente novamente.")
  }
}


extension ShortenerUIModel {
  static func fixed() ->ShortenerUIModel {
    return .init( alias: "abc123",
                  shortURL: "https://short.com",
                  originalURL: "https://full.com")
  }
}

extension AliasResponse {
  static func fixed() -> AliasResponse {
    return .init(
      alias: "abc123",
      links: .init(
        self: "https://full.com",
        short: "https://short.com"
      )
    )
  }
}
