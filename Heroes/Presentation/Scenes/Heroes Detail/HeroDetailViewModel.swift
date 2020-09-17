//
//  HeroDetailViewModel.swift
//  Heroes
//
//  Created by Robihamanto on 17/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol HeroDetailViewModelInput {
}

protocol HeroDetailViewModelOutput {
    var similarHeroes: [Hero] { get }
    var hero: Hero { get }
}

protocol HeroDetailViewModelType {
    var input: HeroDetailViewModelInput { get }
    var output: HeroDetailViewModelOutput { get }
}

class HeroDetailViewModel: HeroDetailViewModelType, HeroDetailViewModelInput, HeroDetailViewModelOutput  {
    
    var hero: Hero
    var heroes: [Hero]
    var similarHeroes = [Hero]()
    
    //MARK: - Input & Output
    var input : HeroDetailViewModelInput { return self }
    var output: HeroDetailViewModelOutput { return self }
    
    init(hero: Hero, heroes: [Hero]) {
        self.hero = hero
        self.heroes = heroes
        
        sortHeroes()
    }
    
    func sortHeroes(){
        var sortedHeroes = heroes
        let primaryAttribute = hero.primaryAttribute ?? ""
        switch primaryAttribute {
        case "agi":
            sortedHeroes = heroes.sorted(by: { $0.moveSpeed ?? 0 < $1.moveSpeed ?? 0})
        case "str":
            sortedHeroes = heroes.sorted(by: { $0.baseAttackMax ?? 0 < $1.baseAttackMax ?? 0})
        case "int":
            sortedHeroes = heroes.sorted(by: { $0.baseMana ?? 0 < $1.baseMana ?? 0})
        default:
            sortedHeroes = heroes
        }
        
        self.similarHeroes = sortedHeroes
    }
    
}
