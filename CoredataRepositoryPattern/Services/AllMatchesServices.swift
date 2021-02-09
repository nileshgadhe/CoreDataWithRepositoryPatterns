//
//  AllMatchesServices.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 04/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct AllMatchesServices {
    
    func apiCallGetAllServices<T:Decodable>(urlRequest: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?) -> Void){
        
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decode = JSONDecoder()
                do {
                    let result = try decode.decode(T.self, from: responseData!)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
}
