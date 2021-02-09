//
//  AllMatchesViewModel.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 04/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct AllMatchesViewModel {
    
    func getAllMatches(completionHandler:@escaping(_ result: Welcome) -> Void){
        
        let allMatchesResource = AllMatchesResource()
        allMatchesResource.getAllMatches { (responseData) in
            completionHandler(responseData)
        }
        
    }
    
    private var databaseManager = DatabaseManager()
    
    func createMatch(match: Venue){
        
        if databaseManager.recordExistInDatabaseOrNot(byId: match.id!){
            
            databaseManager.deleteMatch(byId: match.id!)
        } else{
            
            databaseManager.createMatch(match: match)
        }
    
    }

    func recordExistInDatabaseOrNot(byId : String) -> Bool{
        let result = databaseManager.recordExistInDatabaseOrNot(byId: byId)
        return result
    }

}
