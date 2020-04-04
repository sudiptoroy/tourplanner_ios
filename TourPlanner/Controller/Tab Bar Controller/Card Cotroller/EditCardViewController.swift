//
//  EditCardViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/3/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

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
    
    var updatedCardStatus: Int?
    
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
        if (self.cardStatusReceived == 1) {
            cardStatusSwitch.setOn(true, animated: false)
        } else if (self.cardStatusReceived == 0) {
            cardStatusSwitch.setOn(false, animated: false)
        }
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        // Fetch Updated information from View
        let updatedTitle = cardTitle.text
        let updatedDescription = cardDescription.text
        let updatedPricePerDay = pricePerDay.text
        let updatedCategoryTags = cardCategoryTags.text
        let updatedPlace = place.text
        if (cardStatusSwitch.isOn) {
            updatedCardStatus = 1
        } else {
            updatedCardStatus = 0
        }
        
        // Check if any field(s) is/are empty
        if (updatedTitle != "" && updatedDescription != "" && updatedPricePerDay != "" && updatedCategoryTags != "" && updatedPlace != "") {
            
            let param = ["id": cardIDReceived,
                         "guide_id": guideIDReceived!,
                         "card_title": updatedTitle!,
                         "card_description": updatedDescription!,
                         "price_per_day": updatedPricePerDay!,
                         "place_ids": updatedPlace!,
                         "service_status": serviceStatusReceived!,
                         "card_status": updatedCardStatus!,
                         "card_category_tags": updatedCategoryTags!,
                         "api_key": API.API_key] as [String: Any]
            
            // Call updateCard by card ID api
            Alamofire.request(API.baseURL + "/cards/updateCard", method: .post, parameters: param).validate().responseJSON {
                response in
                
                if ((response.result.value) != nil) {
                    do {
                        //let getCardByGuideResponse = try JSONDecoder().decode(CardByGuide.self, from: response.data!)
                        let editCardResponse = try JSONDecoder().decode(UpdateCard.self, from: response.data!)
                        let message = editCardResponse.message
                        self.displayAlertMessage("Card Updated", message)
                        
                    } catch {
                        print("Error while parsing edit card json response")
                    }
                }
            }
        } else {
            displayAlertMessage("Empty Fields!", "Fields must not be empty")
        }
    }
    
    func displayAlertMessage(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        userAlert.addAction(okAction)
        present(userAlert, animated: true, completion: nil)
    }
}
