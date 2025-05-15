//
//  TabBarViewController.swift
//  LadoB
//
//  Created by Vítor Bruno on 13/05/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    //MARK: TabBar de Search
    lazy var searchTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "Pesquisa"
        tabItem.image = UIImage(systemName: "sparkle.magnifyingglass")
        tabItem.badgeColor = .red
        
        
        let rootViewController = SearchVC() //mudar para a pagina de pesquisa
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()

    //MARK: TabBar de Discoteca
    lazy var discoTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "Discoteca"
        tabItem.image = UIImage(systemName: "square.3.layers.3d.down.backward")
        
        let rootViewController = DiscoVC()
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    //MARK: TabBar de WishList
    lazy var wishListTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "WishList"
        tabItem.image = UIImage(named: "custom.record.circle.fill.badge.sparkles.alt")
        
        let rootViewController = ExampleVC() //mudar para a pagina de pesquisa
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    //MARK: TabBar de Discoteca
    lazy var profileTabBar: UINavigationController = {
        let tabItem = UITabBarItem()
        tabItem.title = "Perfil"
        tabItem.image = UIImage(systemName: "person.fill")
        
        let rootViewController = ExampleVC() //mudar para a pagina de pesquisa
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .yellow1
        tabBar.backgroundColor = .purple1
        viewControllers = [searchTabBar, discoTabBar, wishListTabBar, profileTabBar]
    }

}
