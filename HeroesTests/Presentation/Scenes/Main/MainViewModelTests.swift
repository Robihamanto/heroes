//
//  MainViewModelTests.swift
//  HeroesTests
//
//  Created by Robihamanto on 19/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import XCTest
@testable import Heroes

class MainViewModelTests: XCTestCase {
    
    private enum FetchHeroesUseCaseError: Error {
        case someError
    }

    var heroes = [Hero]()
    
    override func setUp() {
        print("Settup called how much")
        
        let antiMage = Hero(id: 1, localizedName: "Anti-Mage", primaryAttribute: "agi", attackType: "Melee", roles: ["Carry", "Escape", "Nuker"], image: "/apps/dota2/images/heroes/antimage_full.png?", icon: "/apps/dota2/images/heroes/antimage_icon.png", baseHealth: 200, baseMana: 75, baseArmor: -1, baseAttackMax: 33, baseAttackMin: 29, moveSpeed: 310)
        
        let axe = Hero(id: 2, localizedName: "Axe", primaryAttribute: "str", attackType: "Melee", roles: ["Initiator", "Durable"], image: "/apps/dota2/images/heroes/axe_full.png?", icon: "/apps/dota2/images/heroes/axe_icon.png", baseHealth: 200, baseMana: 75, baseArmor: -1, baseAttackMax: 31, baseAttackMin: 27, moveSpeed: 310)
        
        let bane = Hero(id: 3, localizedName: "Bane", primaryAttribute: "int", attackType: "Ranged", roles: ["Support", "Disabler", "Nuker", "Durable"], image: "/apps/dota2/images/heroes/bane_full.png?", icon: "/apps/dota2/images/heroes/bane_icon.png", baseHealth: 200, baseMana: 75, baseArmor: 1, baseAttackMax: 41, baseAttackMin: 35, moveSpeed: 305)
        
        heroes.append(antiMage)
        heroes.append(axe)
        heroes.append(bane)
    }
    
    struct HeroRepositoryMock: HeroRepositoryType {
        
        var result: Result<[Hero], Error>

        func fetchHeroes(cached: @escaping ([Hero]) -> Void, completion: @escaping (Result<[Hero], Error>) -> Void) {
            completion(result)
        }

    }
    
    class FetchHeroesUseCaseMock: FetchHeroesUseCaseType {
        
        var expectation: XCTestExpectation?
        var error: Error?
        var heroes = [Hero]()
        
        func execute(cached: @escaping ([Hero]) -> Void, completion: @escaping ((Result<[Hero], Error>) -> Void)) {
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(heroes))
            }
            
            expectation?.fulfill()
        }
        
        
    }

}
