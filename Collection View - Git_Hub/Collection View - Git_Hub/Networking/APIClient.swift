//
//  APIClient.swift
//  Collection View - Git_Hub
//
//  Created by Mac on 28/03/2563 BE.
//  Copyright © 2563 DND. All rights reserved.
//

import Foundation

enum Either<T>{
    case success(T)
    case error(Error)
}
enum APIError : Error{
    case unknown, badresponse, jsonDecoder, imageDownload, imageConvert
}


protocol APIClient {
    var session : URLSession { get }
    func get<T : Codable>(with request: URLRequest, completion : @escaping (Either<[T]>) ->Void)
    
}
extension APIClient{
    
    var session : URLSession{
        return URLSession.shared
    }
    
    func get<T : Codable>(with request: URLRequest, completion : @escaping (Either<[T]>) ->Void){
        
        let task = session.dataTask(with: request){(data,response,error) in
            guard error == nil else{
                completion(.error(error!))
                return
            }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else{
                 completion(.error(APIError.badresponse))
                return
            }
            guard let value = try? JSONDecoder().decode([T].self, from: data!) else {
                completion(.error(APIError.jsonDecoder))
                return
            }
            //print(T.self)
            //print(value)
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
        task.resume()
    }

}
