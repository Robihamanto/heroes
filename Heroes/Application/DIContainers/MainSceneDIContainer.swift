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
    
    func makeHeroDetailViewController() -> HeroDetailViewController {
        return HeroDetailViewController()
    }
    
    
}

