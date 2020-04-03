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
    let place_ids: String?
    let card_average_rating: Int?
    let service_status: Int?
    let card_status: Int?
    let card_category_tags: String?
    let created_at: String?
    let updated_at: String?
}
