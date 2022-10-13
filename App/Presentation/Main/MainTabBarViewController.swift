import UIKit

class MainTabBarViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }

  private func setupTabBar() {
    tabBar.tintColor = .systemRed
    tabBar.unselectedItemTintColor = .black
    tabBar.backgroundColor = .white
    tabBar.isTranslucent = false
  }
}
