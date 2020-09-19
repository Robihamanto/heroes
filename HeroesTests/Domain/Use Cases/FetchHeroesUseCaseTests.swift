//
//  FetchHeroesUseCaseTests.swift
//  HeroesTests
//
//  Created by Robihamanto on 19/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import XCTest
@testable import Heroes

class FetchHeroesUseCaseTests: XCTestCase {
    
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
    
    func testFetchHeroesUseCaseHasExpectedItemCount() {
        
        let useCase = FetchHeroesUseCase(heroRepository: HeroRepositoryMock(result: .success(heroes)))
        
        useCase.execute(cached: { _ in }) { result in
            switch result {
            case .success(let heroes):
                XCTAssert(heroes.count == 3, "Heroes doesn't give us the right count value")
            case .failure:
                XCTAssert(false, "Cannot fetch Heroes")
            }
        }
        
    }
    
    func testFetchHeroesUseCaseHasExpectedFirstItemValue() {
        
        let useCase = FetchHeroesUseCase(heroRepository: HeroRepositoryMock(result: .success(heroes)))
        
        useCase.execute(cached: { _ in }) { result in
            switch result {
            case .success(let heroes):
                let hero = heroes.first
                XCTAssert(hero?.id == 1)
                XCTAssert(hero?.localizedName == "Anti-Mage")
                XCTAssert(hero?.primaryAttribute == "agi")
                XCTAssert(hero?.attackType == "Melee")
                XCTAssert(hero?.roles?.count == 3)
                XCTAssert(hero?.roles![0] == "Carry")
                XCTAssert(hero?.baseHealth == 200)
                XCTAssert(hero?.baseMana == 75)
                XCTAssert(hero?.baseArmor == -1)
                XCTAssert(hero?.baseAttackMax == 33)
                XCTAssert(hero?.baseAttackMin == 29)
                XCTAssert(hero?.moveSpeed == 310)
                
            case .failure:
                XCTAssert(false, "Cannot fetch Heroes")
            }
        }
    }
    
    func testFetchHeroesUseCaseReturnError() {
        
        let useCase = FetchHeroesUseCase(heroRepository: HeroRepositoryMock(result: .failure(FetchHeroesUseCaseError.someError)))
        
        useCase.execute(cached: { _ in }) { result in
            switch result {
            case .success:
                XCTAssert(false, "Fetch Heroes Successful")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
    }

}
