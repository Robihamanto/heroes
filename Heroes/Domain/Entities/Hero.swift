//
//  Hero.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

struct Hero: Codable {
    
    var id: Int?
    var localizedName: String?
    var primaryAttribute: String?
    var attackType: String?
    var roles: [String]?
    var image: String?
    var icon: String?
    var baseHealth: Int?
    var baseMana: Int?
    var baseArmor: Float32?
    var baseAttackMax: Int?
    var baseAttackMin: Int?
    var moveSpeed: Int?
    
    var link: String {
        return "https://api.opendota.com\(image ?? "")"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id               = "id"
        case localizedName    = "localized_name"
        case primaryAttribute = "primary_attr"
        case attackType       = "attack_type"
        case roles            = "roles"
        case image            = "img"
        case icon             = "icon"
        case baseHealth       = "base_health"
        case baseMana         = "base_mana"
        case baseArmor        = "base_armor"
        case baseAttackMax    = "base_attack_max"
        case baseAttackMin    = "base_attack_min"
        case moveSpeed        = "move_speed"
    }
}
