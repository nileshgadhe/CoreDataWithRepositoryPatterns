//
//  SavedMatchesRepository.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 09/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import CoreData

protocol SavedMatchesRepository {
    func create(match: Venue)
    func getAll() -> [SavedMatches]?
    func get(byId: String) -> SavedMatches?
    func delete(byId: String)
}

struct SavedMatchesDataRepository: SavedMatchesRepository {
    
    func create(match: Venue) {
        let saveMatch = SavedMatches(context: PersistentStorage.shared.context)
        saveMatch.matchId = match.id!
        saveMatch.matchName = match.name!
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [SavedMatches]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(SavedMatches.fetchRequest()) as? [SavedMatches] else{return nil}
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func get(byId: String) -> SavedMatches? {
        let fetchRequest = NSFetchRequest<SavedMatches>(entityName: "SavedMatches")
        let predicate = NSPredicate(format: "matchId==%@", byId as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else{return nil}
            return result
            
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func delete(byId: String) {
        
        let record = get(byId: byId)
        guard record != nil else{return}
        if recordExistInDatabaseOrNot(byId: byId){
            PersistentStorage.shared.context.delete(record!)
        }
    }
    
    func recordExistInDatabaseOrNot(byId : String) -> Bool{
        
        let fetchRequest = NSFetchRequest<SavedMatches>(entityName: "SavedMatches")
        let predicate = NSPredicate(format: "matchId==%@", byId as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else{return false}
            return true
            
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        
    }
    
}
