//
//  UnplasImage.swift
//  Collection View - Git_Hub
//
//  Created by Mac on 28/03/2563 BE.
//  Copyright © 2563 DND. All rights reserved.
//

import Foundation

typealias Photos = [Photo]

struct Photo : Codable {
    let id : String
    let urls : URLS
}
struct URLS : Codable {
    let raw : URL
    let full : URL
    let regular : URL
    let small : URL
    let thumb : URL
}
