//
//  AllMatchesModel.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 04/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let response: Response
}

// MARK: - Response
struct Response: Decodable {
    let venues: [Venue]
}

// MARK: - Venue
struct Venue: Decodable {
    let id, name: String?
}
