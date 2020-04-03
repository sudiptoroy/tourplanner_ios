//
//  EditCardViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/3/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class EditCardViewController: UIViewController {

    var cardIDReceived = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Card"
        print("Card ID received in Edit Card")
        print(cardIDReceived)
        // Do any additional setup after loading the view.
    }

}
