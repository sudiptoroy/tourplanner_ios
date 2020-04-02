//
//  ShowCardsViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class ShowCardsViewController: UIViewController {
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Id in show card")
        print(id as Any)
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createCardViewController = segue.destination as? CreateCardViewController {
            createCardViewController.id = id
        }
    }

}
