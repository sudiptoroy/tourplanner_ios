//
//  ProfileNavigationController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/6/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class ProfileNavigationController: UINavigationController {
    
    var guide_id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Guide id in ProfileNavigation \(String(describing: guide_id))")
        // Do any additional setup after loading the view.
    }

}
