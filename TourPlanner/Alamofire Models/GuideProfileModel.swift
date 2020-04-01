//
//  GuideProfileModel.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/1/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation


struct GuideProfile: Decodable {
    let success: Bool
    let data: [GuideProfileInfo]
}

struct GuideProfileInfo: Decodable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let email: String?
    let email_verified_at: String?
    let image: String?
    let gender: String?
    let phone_no: String?
    let nid_no: String?
    let nid_image: String?
    let mark_sheet: String?
    let special_certificate: String?
    let date_of_birth: String?
    let urgent_availability: Int?
    let is_available: Int?
    let ratings: Double?
    let latitude: Double?
    let longitude: Double?
    let is_verified: Int?
    let house_no: String?
    let postal_code: Int?
    let road: String?
    let police_station: String?
    let area: String?
    let district: String?
    let division: String?
}
