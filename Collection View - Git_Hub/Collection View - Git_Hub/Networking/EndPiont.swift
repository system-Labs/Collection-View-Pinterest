//
//  EndPiont.swift
//  Collection View - Git_Hub
//
//  Created by Mac on 28/03/2563 BE.
//  Copyright © 2563 DND. All rights reserved.
//

import Foundation

protocol EndPoint {
    var baseUrl : String { get  }
    var path : String { get  }
    var urlParametets : [URLQueryItem] { get }
}

extension EndPoint{
    var urlComponent : URLComponents{
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParametets
        return urlComponent!
    }
    var request : URLRequest{
        return URLRequest(url: urlComponent.url!)
    }
}

enum Order : String {
    case popular,latest,oldest
}

enum UnspashEndPoint : EndPoint{
    case photos(id : String, order:Order)
    
    var baseUrl: String{
        return "https://api.unsplash.com"
    }
    
    var path : String{
        switch self {
        case .photos:
            return "/photos"
        }
    }
    var urlParametets: [URLQueryItem]{
        switch self {
        case .photos(let id,let order):
            return [
                URLQueryItem(name: "client_id", value: id),
                URLQueryItem(name: "order_by", value: order.rawValue)
                ]
        }

    }
}
