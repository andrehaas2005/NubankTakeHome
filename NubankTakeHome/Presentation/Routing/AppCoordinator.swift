//
//  AppCoordinator.swift
//  NubankTakeHome
//
//  Created by Andre  Haas on 05/12/25.
//


import UIKit

final class AppCoordinator {
  
  private let navigationController: UINavigationController
  private let container: DIContainer
  
  init(
    navigationController: UINavigationController,
    container: DIContainer
  ) {
    self.navigationController = navigationController
    self.container = container
  }
  
  func start() {
    let router = ShortenerRouter(navigationController: navigationController)
    let vc = container.makeShortenerViewController(router: router)
    navigationController.setViewControllers([vc], animated: false)
  }
}
