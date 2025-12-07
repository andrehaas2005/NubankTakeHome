import Foundation
import Core
@testable import NubankTakeHome

final class LinkRepositoryMock: LinkRepositoryProcotol {
  
  var initial: [AliasResponse] = []
  var saved: [AliasResponse] = []
  
  func save(_ alias: AliasResponse) {
    saved.append(alias)
  }
  
  func all() -> [AliasResponse] {
    initial + saved
  }
  
  func clear() {
    initial.removeAll()
    saved.removeAll()
  }
}
