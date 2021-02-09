//
//  AllMatchesResource.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 04/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct AllMatchesResource {
    
    
    func getAllMatches(completionHandler : @escaping (_ result : Welcome) -> Void ){
        
        let urlRequest = URL(string: "https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616")!
        
        let allMatchesService = AllMatchesServices()
        allMatchesService.apiCallGetAllServices(urlRequest: urlRequest, resultType: Welcome.self) { (responseData) in
            
            completionHandler(responseData!)
        }
        
    }
    
}
