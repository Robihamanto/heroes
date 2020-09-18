//
//  HeroesResponseStorage.swift
//  Heroes
//
//  Created by Robihamanto on 18/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation
import CoreData

protocol HeroesResponseStorage {
    func getResponse(hero: Hero, completion: @escaping (Result<Hero?, CoreDataStorageError>) -> Void)
    func save(hero: Hero)
    func save(heros: [Hero])
}


final class CoreDataHeroesResponseStorage {
    
    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    // MARK: - Private

    private func fetchRequest(hero: Hero) -> NSFetchRequest<HeroEntity> {
        let request: NSFetchRequest = HeroEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", hero.id ?? 0)
        return request
    }
    
    private func fetchRequest() -> NSFetchRequest<HeroEntity> {
        let request: NSFetchRequest = HeroEntity.fetchRequest()
        return request
    }
    
    private func deleteResponse(hero: Hero, in context: NSManagedObjectContext) {
        let request = fetchRequest(hero: hero)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
    
}

extension CoreDataHeroesResponseStorage: HeroesResponseStorage {
    
    func getResponse(hero: Hero, completion: @escaping (Result<Hero?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask {context in
            do {
                let fetchRequest = self.fetchRequest(hero: hero)
                let requestEntity = try context.fetch(fetchRequest).first
                
                completion(.success(requestEntity?.toObject()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(hero: Hero) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(hero: hero, in: context)
                
                _ = hero.toEntity(in: context)
                try context.save()
                
            } catch {
                debugPrint("CoreDataHeroesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    func save(heros: [Hero]) {
        coreDataStorage.performBackgroundTask { context in
            do {
                
                for hero in heros {
                    self.deleteResponse(hero: hero, in: context)
                    
                    let _ = hero.toEntity(in: context)
                    try context.save()
                }
                
            } catch {
                debugPrint("CoreDataHeroesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

}
