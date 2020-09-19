//
//  MainCoordinator.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation
import UIKit

protocol MainCoordinatorDependencies  {
    func makeMainViewController() -> MainViewController
    func makeHeroDetailViewController() -> HeroDetailViewController
}

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    private let dependencies: MainCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: MainCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToHeroDetail(withHero hero: Hero, andHeroes heroes: [Hero]) {
        let vc = HeroDetailViewController.instantiate()
        vc.coordinator = self
        vc.hero = hero
        vc.heroes = heroes
        navigationController.pushViewController(vc, animated: true)
    }
}
