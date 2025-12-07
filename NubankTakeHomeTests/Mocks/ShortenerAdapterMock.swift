import Foundation
import Core
@testable import NubankTakeHome

final class ShortenerAdapterMock: ShortenerAdapterProtocol {
  
  var ui: [ShortenerUIModel] = []
  
  func toUIModels(_ list: [AliasResponse]) -> [ShortenerUIModel] {
    ui
  }
}
