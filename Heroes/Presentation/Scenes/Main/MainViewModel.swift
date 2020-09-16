//
//  MainViewModel.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MainViewModelInput {
    
}

protocol MainViewModelOutput {
    var heroes: PublishSubject<[Hero]> { get }
    var error: PublishSubject<String> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelType, MainViewModelInput, MainViewModelOutput  {
    
    var heroes: PublishSubject<[Hero]>
    var error: PublishSubject<String>
    var isLoading: BehaviorRelay<Bool>
    
    //MARK: - Input & Output
    var input : MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    var fetchHeroesUseCase: FetchHeroesUseCase
    
    init() {
        
        fetchHeroesUseCase = FetchHeroesUseCase(heroRepository: HeroRepository())
        
        heroes = heroesProperty
        error = errorProperty
        isLoading = isLoadingProperty
        
        isLoadingProperty.accept(true)
        fetchHeroesUseCase.execute { [weak self] result in
            switch result {
            case .success(let heroes):
                self?.isLoadingProperty.accept(false)
                self?.heroesProperty.onNext(heroes)
            case .failure(let error):
                self?.isLoadingProperty.accept(false)
                self?.errorProperty.onNext(error.localizedDescription)
            }
        }
        
    }
    
    var heroesProperty: PublishSubject<[Hero]> = PublishSubject()
    var errorProperty: PublishSubject<String> = PublishSubject()
    var isLoadingProperty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
}
