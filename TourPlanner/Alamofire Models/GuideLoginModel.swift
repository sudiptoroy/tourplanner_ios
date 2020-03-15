//
//  GuideLoginModel.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 3/14/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation




struct Guide :Decodable {
    let success: Bool
    let message: String
    let data: [User]
    
}

struct User :Decodable {
    let id: Int?
    let email: String?
    let is_verified: Bool?
    
//    init( success: Bool?,
//          data: [User] = [])
//    {
//        self.success = success ?? false
//        self.data = data
//    }
}

