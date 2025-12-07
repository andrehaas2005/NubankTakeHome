import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private let container = DIContainer()
  private var coordinator: AppCoordinator?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    
    let navigation = UINavigationController()
    navigation.navigationBar.prefersLargeTitles = true
    
    let coordinator = AppCoordinator(
      navigationController: navigation,
      container: container
    )
    self.coordinator = coordinator
    
    coordinator.start()
    
    window.rootViewController = navigation
    window.makeKeyAndVisible()
  }
}
