//
//  TabBarViewController.swift
//  LadoB
//
//  Created by Vítor Bruno on 13/05/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    lazy var searchTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "Pesquisa"
        tabItem.image = UIImage(systemName: "sparkle.magnifyingglass")
        
        let rootViewController = SearchVC()
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()

    lazy var discoTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "Discoteca"
        tabItem.image = UIImage(systemName: "square.3.layers.3d.down.backward")
        
        let rootViewController = DiscoVC()
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    lazy var wishListTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "WishList"
        tabItem.image = UIImage(named: "custom.record.circle.fill.badge.sparkles.alt")
        
        let rootViewController = WishListVC()
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    lazy var profileTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "Perfil"
        tabItem.image = UIImage(systemName: "person.fill")
        
        let rootViewController = ExampleVC()
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .yellow1

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black5
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        viewControllers = [searchTabBar, discoTabBar, wishListTabBar, profileTabBar]
    }
}
