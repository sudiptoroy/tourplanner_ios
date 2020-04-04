//
//  EditCardViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/3/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class EditCardViewController: UIViewController {

    @IBOutlet weak var cardTitle: UITextField!
    @IBOutlet weak var cardDescription: UITextView!
    @IBOutlet weak var pricePerDay: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var cardCategoryTags: UITextField!
    @IBOutlet weak var cardStatusSwitch: UISwitch!
    
    
    var cardIDReceived = ""
    var guideIDReceived: Int?
    var cardTitleReceived: String?
    var cardDescriptionReceived: String?
    var pricePerDayReceived: Int?
    var placeIDsReceived: String?
    var serviceStatusReceived: Int?
    var cardStatusReceived: Int?
    var cardTagsReceived: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Card"
        print ("===== Edit Card View ======")
        print("Card ID received: \(cardIDReceived)")
        print("Guide ID received: \(String(describing: guideIDReceived)) \n")
        print("Card Description Received: \n \(String(describing: cardDescriptionReceived)) \n")
        print("Price Per Day Received: \(String(describing: pricePerDayReceived))")
        print("Place Ids: \(String(describing: placeIDsReceived))")
        print("Service Status: \(String(describing: serviceStatusReceived))")
        print("Card Status: \(String(describing: cardStatusReceived))")
        print("Card Tags: \(String(describing: cardTagsReceived))")
        
        
        self.cardCurrentState()
    }
    
    
    func cardCurrentState () {
        self.cardTitle.text = cardTitleReceived
        self.cardDescription.text = cardDescriptionReceived
        self.pricePerDay.text = String(pricePerDayReceived!)
        self.place.text = placeIDsReceived
        self.cardCategoryTags.text = cardTagsReceived
//        if (self.cardStatusReceived == 1) {
//
//        }
    }

}
