//
//  HeroRepository.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

class HeroRepository {
    
    private let service: DotaService
    private let cache: HeroesResponseStorage
    
    init(service: DotaService = DotaService(),
         cache: HeroesResponseStorage = CoreDataHeroesResponseStorage()) {
        self.service = service
        self.cache = cache
    }
    
}

extension HeroRepository: HeroRepositoryType {
    
    func fetchHeroes(cached: @escaping ([Hero]) -> Void, completion: @escaping (Result<[Hero], Error>) -> Void) {
        
        cache.getResponse { result in
            switch result {
            case .success(let value):
                cached(value)
            case .failure(let error):
                print("Error: ", error)
            }
        }
        
        
        service.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.cache.save(heros: heroes)
                completion(.success(heroes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
