//
//  FetchHeroesUseCase.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol FetchHeroesUseCaseType {
    func execute(completion : @escaping((Result<[Hero], Error>) -> Void))
}

final class FetchHeroesUseCase: FetchHeroesUseCaseType {
    
    private let heroRepository: HeroRepositoryType
    
    init(heroRepository: HeroRepositoryType) {
        self.heroRepository = heroRepository
    }
    
    func execute(completion: @escaping ((Result<[Hero], Error>) -> Void)) {
        heroRepository.fetchHeroes { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
