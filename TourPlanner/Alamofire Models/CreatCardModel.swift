//
//  CreatCardModel.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation


struct CreateCard: Decodable {
    
    let success: Bool
    let message: String
    let data: [Card]
}


struct Card: Decodable {
    
    let guide_id: Int?
    let card_title: String?
    let card_description: String?
    let price_per_day: Int?
    let place_ids: String?
    let service_status: Int?
    let card_status: Int?
    let card_category_tags: String?
    let updated_at: String?
    let created_at: String?
    let id: Int?
    
}
