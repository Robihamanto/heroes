//
//  HeroRepositoryType.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol HeroRepositoryType {
    
    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void)
    
}
