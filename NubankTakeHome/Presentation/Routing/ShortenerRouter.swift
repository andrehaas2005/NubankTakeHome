import UIKit
import Core

protocol ShortenerRouting {
  func openShortURL(_ alias: AliasResponse)
  func showError(message: String, in controller: UIViewController?)
}

final class ShortenerRouter: ShortenerRouting {
  
  private weak var navigationController: UINavigationController?
  
  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }
  
  func openShortURL(_ alias: AliasResponse) {
    guard let url = URL(string: alias.links.short) else { return }
    UIApplication.shared.open(url)
  }
  
  func showError(message: String, in controller: UIViewController?) {
    let alert = UIAlertController(
      title: "Erro",
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    controller?.present(alert, animated: true)
  }
}
