//
//  GetCardByGuideModel.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation


struct CardByGuide: Decodable {
    let success: Bool
    let data: [Card]
}

struct Card: Decodable {
    
    let id: Int?
    let card_title: String?
    let guide_id: Int?
    let card_description: String?
    let price_per_hour: Int?
    let price_per_day: Int?
    let place_ids: String?
    let card_average_rating: Double?
    let service_status: Int?
    let card_status: Int?
    let card_category_tags: String?
    let created_at: String?
    let updated_at: String?
}

//"id": 3,
//"card_title": "I'll help to visit Dhaka",
//"guide_id": 8,
//"card_description": "Dhaka is the capital of Bangladesh",
//"price_per_hour": 5,
//"price_per_day": 30,
//"place_ids": "1,2,3",
//"card_average_rating": null,
//"service_status": 0,
//"card_status": 1,
//"card_category_tags": "Dhaka",
//"created_at": "2020-04-01 17:27:12",
//"updated_at": "2020-04-01 17:27:12"
