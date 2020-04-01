//
//  MainTabBarController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/1/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            if let homeViewController = viewController as? HomeViewController {
                homeViewController.id = id
            }
        }
    }
}
