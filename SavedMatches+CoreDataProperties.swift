//
//  SavedMatches+CoreDataProperties.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 07/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedMatches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedMatches> {
        return NSFetchRequest<SavedMatches>(entityName: "SavedMatches")
    }

    @NSManaged public var matchId: String?
    @NSManaged public var matchName: String?

}
