//
//  CardCollectionViewCell.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardRating: UILabel!
    @IBOutlet weak var pricePerDay: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var serviceStatus: UILabel!
}
