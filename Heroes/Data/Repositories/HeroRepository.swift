//
//  HeroRepository.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

class HeroRepository: HeroRepositoryType {
    
    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        let service = DotaService()
        service.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                completion(.success(heroes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
