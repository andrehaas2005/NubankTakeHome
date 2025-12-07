import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private let container = DIContainer()
  private var coordinator: AppCoordinator?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
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
    
    return true
  }
}
