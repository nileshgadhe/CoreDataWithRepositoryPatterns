//
//  SavedMatchesViewModel.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 09/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation


struct SavedMatchesViewModel {
    
    private var databaseManager = DatabaseManager()
    
    func getSavedMAtchesList() -> [SavedMatches]?{
        
        do {
            guard let result = try PersistentStorage.shared.context.fetch(SavedMatches.fetchRequest()) as? [SavedMatches] else{return nil}
            
            return result
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
        
    }
    
    func createMatch(match: Venue){
        
        if databaseManager.recordExistInDatabaseOrNot(byId: match.id!){
            
            databaseManager.deleteMatch(byId: match.id!)
        } else{
            
            databaseManager.createMatch(match: match)
        }
    
    }
    
}
