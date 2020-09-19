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
    var heroesByRole: PublishSubject<[String:[Hero]]> { get }
    var roles: PublishSubject<[String]> { get }
    var error: PublishSubject<String> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelType, MainViewModelInput, MainViewModelOutput  {
    
    var heroesByRole: PublishSubject<[String : [Hero]]>
    var heroes: PublishSubject<[Hero]>
    var roles: PublishSubject<[String]>
    var error: PublishSubject<String>
    var isLoading: BehaviorRelay<Bool>
    
    //MARK: - Input & Output
    var input : MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    var fetchHeroesUseCase: FetchHeroesUseCaseType
    
    init(fetchHeroesUseCase: FetchHeroesUseCaseType) {
        
        self.fetchHeroesUseCase = fetchHeroesUseCase
        
        heroesByRole = heroesByRoleProperty
        heroes = heroesProperty
        roles = rolesProperty
        error = errorProperty
        isLoading = isLoadingProperty
        
        isLoadingProperty.accept(true)
        fetchHeroesUseCase.execute(cached: populateHeroes) { [weak self] result in
            switch result {
            case .success(let heroes):
                self?.isLoadingProperty.accept(false)
                self?.populateHeroes(heroes)
            case .failure(let error):
                self?.isLoadingProperty.accept(false)
                self?.errorProperty.onNext(error.localizedDescription)
            }
        }
        
    }
    
    private var heroesByRoleProperty: PublishSubject<[String:[Hero]]> = PublishSubject()
    private var heroesProperty: PublishSubject<[Hero]> = PublishSubject()
    private var rolesProperty: PublishSubject<[String]> = PublishSubject()
    private var errorProperty: PublishSubject<String> = PublishSubject()
    private var isLoadingProperty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func populateHeroes(_ heroes: [Hero]) {
        var heroesByrole = [String:[Hero]]()
        var heroRoles = [String]()
        
        for hero in heroes {
            if let roles = hero.roles {
                for role in roles {
                    
                    if heroesByrole[role]?.count ?? 0 > 0 {
                        heroesByrole[role]?.append(hero)
                    } else {
                        heroesByrole[role] = [hero]
                    }
                    
                    if !heroRoles.contains(role) {
                        heroRoles.append(role)
                    }
                }
            }
        }
        
        heroesByrole["All"] = heroes
        heroRoles = heroRoles.sorted(by: { $0 < $1 })
        heroRoles.append("All")
        
        DispatchQueue.main.async {
            self.heroesProperty.onNext(heroes)
            self.heroesByRoleProperty.onNext(heroesByrole)
            self.rolesProperty.onNext(heroRoles)
        }
    }
}
