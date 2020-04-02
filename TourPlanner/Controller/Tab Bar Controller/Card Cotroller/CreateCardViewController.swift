//
//  CreateCardViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class CreateCardViewController: UIViewController {
    
    @IBOutlet weak var carTitleTextField: UITextField!
    @IBOutlet weak var cardDetailsTextField: UITextField!
    @IBOutlet weak var pricePerDayTextField: UITextField!
    @IBOutlet weak var pricePerHourTextField: UITextField!
    @IBOutlet weak var selectPlaceTextField: UITextField!
    @IBOutlet weak var cardTagsTextField: UITextField!
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id =")
        print(id as Any)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
        let cardTitle = carTitleTextField.text
        let cardDetails = cardDetailsTextField.text
        let pricePerDay = pricePerDayTextField.text
        let pricePerHour = pricePerHourTextField.text
        let selectPlace = selectPlaceTextField.text
        let cardTags = cardTagsTextField.text
        
        print(pricePerHour as Any)
        
//        let param = ["id" : id!,
//                     "api_key": API.API_key] as [String: Any]
        
        let param = ["guide_id" : id!,
                     "card_title" : cardTitle!,
                     "card_description" : cardDetails!,
                     "price_per_day" : pricePerDay!,
                     "place_ids" : selectPlace!,
                     "service_status" : 0,
                     "card_status" : 1,
                     "card_category_tags" : cardTags!,
                     "api_key" : API.API_key
                     ] as [String: Any]
        
        if (cardTitle != "" && cardDetails != "" && pricePerDay != "" && selectPlace != "" && cardTags != "") {
            
            Alamofire.request(API.baseURL + "/cards/setCard", method: .post, parameters: param).validate().responseJSON {
                response in
                
                do {
                    //let guideProfileResponse = try JSONDecoder().decode(GuideProfile.self, from: response.data!)
                    let createCardResponse = try JSONDecoder().decode(CreateCard.self, from: response.data!)
                    let message = createCardResponse.message
                    self.displayAlertMessage("Card Created", message)
                    
                } catch {
                    print("Error While Parsing Json. Check the API model again")
                }
                
            }
            
        } else {
            displayAlertMessage("Invalid Input", "You must enter all fields")
        }
        
    }
    
    // Function to display alert message
    func displayAlertMessage(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        userAlert.addAction(okAction)
        self.present(userAlert, animated: true, completion: nil)
    }

    

}
