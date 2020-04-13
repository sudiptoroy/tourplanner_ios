//
//  TouristProfileViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/12/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class TouristProfileViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var touristName: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    
    var touristIDReceived = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n============= Touist Profile View ===============")
        print("Tourist Id Received: \(touristIDReceived)")
    }
}
