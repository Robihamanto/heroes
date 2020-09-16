//
//  Dota.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Moya

enum Dota {
    case fetchHeroes
}

extension Dota: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.opendota.com/api") else {
            fatalError("FAILED: https://api.opendota.com/api")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchHeroes:
            return "/herostats"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchHeroes:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .fetchHeroes:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchHeroes:
            return [:]
        }
    }
    
}
