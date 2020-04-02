//
//  CardNavigationCrontroller.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation
import UIKit

class CardNavigationCrontroller: UINavigationController {
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id in navigation")
        print(id as Any)
    }
}
