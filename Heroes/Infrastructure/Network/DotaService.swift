//
//  DotaService.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Moya

protocol DotaServiceType {
    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void)
}

class DotaService: DotaServiceType {
    
    private let provider = MoyaProvider<Dota>(plugins: [NetworkLoggerPlugin()])
    
    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        provider.request(.fetchHeroes) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode([Hero].self, from: response.data)
                    completion(.success(response))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
