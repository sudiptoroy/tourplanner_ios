//
//  TouristProfileModel.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/9/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation

struct TouristProfile: Decodable {
    let success: Bool
    let data: [TouristProfileDetails]
}

struct TouristProfileDetails: Decodable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let image: String?
    let gender: String?
    let date_of_birth: String?
    let country: String?
}

//"id": 7,
//"first_name": "Corona",
//"last_name": "Virus",
//"image": "dummy",
//"gender": "Unspecified",
//"date_of_birth": "2020-02-14",
//"country": "China"
