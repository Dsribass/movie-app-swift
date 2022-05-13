import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func getViewControllers() -> [UIViewController]{
        let movieSummaryViewController = MovieSummaryViewController()
        let favoritesViewController = FavoritesViewController()
        
        movieSummaryViewController.setTabBarImage(imageName: "film", title: "Filmes")
        favoritesViewController.setTabBarImage(imageName: "star", title: "Favoritos")
        
        return [movieSummaryViewController, favoritesViewController]
    }
    
    private func setupTabBar() {
        viewControllers = getViewControllers()
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
    }

}
