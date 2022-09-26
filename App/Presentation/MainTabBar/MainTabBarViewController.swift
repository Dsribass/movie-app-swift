import UIKit

class MainTabBarViewController: UITabBarController {
  let movieSummaryViewController: MovieSummaryViewController
  let favoritesViewController: FavoritesViewController

  init(
    movieSummaryViewController: MovieSummaryViewController,
    favoritesViewController: FavoritesViewController
  ) {
    self.movieSummaryViewController = movieSummaryViewController
    self.favoritesViewController = favoritesViewController
    super.init(nibName: "MainTabBarViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }
}

extension MainTabBarViewController {
  private func getViewControllers() -> [UIViewController] {
    movieSummaryViewController.setTabBarImage(imageName: "film", title: "Filmes")
    favoritesViewController.setTabBarImage(imageName: "star", title: "Favoritos")

    return [
      UINavigationController(rootViewController: movieSummaryViewController),
      favoritesViewController
    ]
  }

  private func setupTabBar() {
    viewControllers = getViewControllers()
    tabBar.tintColor = .systemRed
    tabBar.unselectedItemTintColor = .black
    tabBar.backgroundColor = .white
    tabBar.isTranslucent = false
  }
}
