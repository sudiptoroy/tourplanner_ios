//
//  MyTourDetailsViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/9/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class MyTourDetailsViewController: UIViewController {
    
    var cardIDReceived = ""
    var touristIDReceived = ""
    var relationIDReceived = ""
    var guideIDReceived: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n========= My Tour Details View ===========")
        print("Relation ID: \(relationIDReceived)")
        print("Card ID: \(cardIDReceived)")
        print("Tourist ID \(touristIDReceived)")
    }
}
