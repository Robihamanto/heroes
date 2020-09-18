//
//  HeroEntity+Mapping.swift
//  Heroes
//
//  Created by Robihamanto on 18/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation
import CoreData

extension HeroEntity {
    
    func toObject() -> Hero {
        return .init(id: Int(id),
                     localizedName: localizedName,
                     primaryAttribute: primaryAttribute,
                     attackType: attackType,
                     roles: roles,
                     image: image,
                     icon: icon,
                     baseHealth: Int(baseHealth),
                     baseMana: Int(baseMana),
                     baseArmor: Float32(baseArmor),
                     baseAttackMax: Int(baseAttackMax),
                     baseAttackMin: Int(baseAttackMin),
                     moveSpeed: Int(moveSpeed))
    }
    
}

extension Hero {
    
    func toEntity(in context: NSManagedObjectContext) -> HeroEntity {
        let entity: HeroEntity = .init(context: context)
        entity.id = Int64(id ?? 0)
        entity.localizedName = localizedName
        entity.primaryAttribute = primaryAttribute
        entity.attackType = attackType
        entity.roles = roles
        entity.image = image
        entity.icon = icon
        entity.baseHealth = Int64(baseHealth ?? 0)
        entity.baseMana = Int64(baseMana ?? 0)
        entity.baseArmor = Float(baseArmor ?? 0)
        entity.baseAttackMax = Int64(baseAttackMax ?? 0)
        entity.baseAttackMin = Int64(baseAttackMin ?? 0)
        entity.moveSpeed = Int64(moveSpeed ?? 0)
        
        return entity
    }
    
}
