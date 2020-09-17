//
//  MainCoordinator.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController.instantiate()
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
