//
//  UnsplasClient.swift
//  Collection View - Git_Hub
//
//  Created by Mac on 28/03/2563 BE.
//  Copyright © 2563 DND. All rights reserved.
//

import Foundation

class UnspalshClient : APIClient{
    
    static let baseUrl = "https://api.unsplash.com"
    static let apiKey = "YttK1qKKQ0j7DEuQixvyxuZJSY1iVTPRIAMXLlzznPk"
    
    func fetch(with endPoint : UnspashEndPoint,completion : @escaping (Either<Photos>) -> Void){
        let request = endPoint.request
        get(with: request, completion: completion)
    }
}
