//
//  GetCardByCardIDModel.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/3/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation


struct CardByID: Decodable {
    let success: Bool
    let data: [CardByIDDetails]
}

struct CardByIDDetails: Decodable {
    let id: Int?
    let card_title: String?
    let card_description: String?
    let price_per_hour: Int?
    let price_per_day: Int?
    let place_ids: String?
    let card_average_rating: Double?
    let service_status: Int?
    let card_status: Int?
    let card_category_tags: String?
    
}
