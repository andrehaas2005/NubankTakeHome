import UIKit
import Core
@testable import NubankTakeHome

final class ShortenerRoutingMock: ShortenerRouting {
  private(set) var alias: AliasResponse?
  private(set) var controller: UIViewController?
  private(set) var message: String?
  private(set) var openShortURLCall = 0
  private(set) var showErrorCall = 0
  private(set) var showToastCall = 0
  
  
  func openShortURL(_ alias: Core.AliasResponse) {
    openShortURLCall += 1
    self.alias = alias
  }
  
  func showError(message: String, in controller: UIViewController?) {
    showErrorCall += 1
    self.message = message
    self.controller = controller
  }
  
  func showToast(in controller: UIViewController?) {
    showToastCall += 1
    self.controller = controller
  }
}
