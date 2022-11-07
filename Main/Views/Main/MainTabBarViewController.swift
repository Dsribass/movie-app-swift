import UIKit

class MainTabBarViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }

  private func setupTabBar() {
    tabBar.tintColor = .systemRed
    tabBar.backgroundColor = .systemBackground
    tabBar.isTranslucent = false
  }
}
