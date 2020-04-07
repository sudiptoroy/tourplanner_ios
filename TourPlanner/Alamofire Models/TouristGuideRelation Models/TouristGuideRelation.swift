//
//  TouristGuideRelation.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/7/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation

struct TouristGuideRelation: Decodable {
    let success: Bool
    let data: [TouristGuideData]
}

struct TouristGuideData: Decodable {
    
    let id: Int?
    let card_id: Int?
    let tourists_id: Int?
    let guide_id: Int?
    let is_accepted: Int?
    let is_complited: Int?
    let is_cancelled_by_tourist: Int?
    let is_cancelled_by_guide: Int?
    let created_at: String?
    let updated_at: String?
    
}
