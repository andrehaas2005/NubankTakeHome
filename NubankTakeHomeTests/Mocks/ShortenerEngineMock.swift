import Foundation
import Core
@testable import NubankTakeHome

final class ShortenerEngineMock: ShortenerEngineProtocol {
  
  enum Mode {
    case success(AliasResponse)
    case failure(Error)
    case none
  }
  
  var mode: Mode = .none
  
  func shorten(_ url: String) async throws -> AliasResponse {
    switch mode {
    case .success(let response):
      return response
    case .failure(let error):
      throw error
    case .none:
      throw NSError(domain: "EngineMock", code: -1)
    }
  }
}
