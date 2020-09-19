//
//  MainSceneDIContainer.swift
//  Heroes
//
//  Created by Robihamanto on 19/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

final class MainSceneDIContainer: MainCoordinatorDependencies {
    
    func makeHeroRepository() -> HeroRepository {
        return HeroRepository()
    }
    
    //MARK: - HeroesList
    
    func makeMainViewController() -> MainViewController {
        let vc = MainViewController.instantiate()
        vc.create(viewModel: makeMainViewModel())
        return vc
    }
    
    func makeMainViewModel() -> MainViewModel {
        return MainViewModel(fetchHeroesUseCase: makeFetchHeroesUseCase())
    }
    
    func makeFetchHeroesUseCase() -> FetchHeroesUseCase {
        return FetchHeroesUseCase(heroRepository: makeHeroRepository())
    }
    
    //MARK: - Hero Detail
    
    func makeHeroDetailViewController(hero: Hero, heroes: [Hero]) -> HeroDetailViewController {
        let vc = HeroDetailViewController.instantiate()
        vc.create(viewModel: makeHeroDetailViewModel(hero: hero, heroes: heroes))
        return vc
    }
    
    func makeHeroDetailViewModel(hero: Hero, heroes: [Hero]) -> HeroDetailViewModel {
        return HeroDetailViewModel(hero: hero, heroes: heroes)
    }
    
    
}

