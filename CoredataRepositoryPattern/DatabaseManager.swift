//
//  DatabaseManager.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 09/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct DatabaseManager {
    
    private var savedMatchesDataRepository = SavedMatchesDataRepository()
    
    func createMatch(match: Venue){
        savedMatchesDataRepository.create(match: match)
    }
    
    func getAllMatches() -> [SavedMatches]?{
        
        let allMatches = savedMatchesDataRepository.getAll()
        return allMatches
        
    }
    
    func getMatch(byId: String) -> SavedMatches?{
        
        let match = savedMatchesDataRepository.get(byId: byId)
        return match
    }
    
    func deleteMatch(byId: String){
        savedMatchesDataRepository.delete(byId: byId)
    }
    
    func recordExistInDatabaseOrNot(byId : String) -> Bool{
        let result = savedMatchesDataRepository.recordExistInDatabaseOrNot(byId: byId)
        return result
    }
    
}
