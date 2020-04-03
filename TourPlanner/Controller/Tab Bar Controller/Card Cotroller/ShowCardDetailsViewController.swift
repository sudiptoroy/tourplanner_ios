//
//  ShowCardDetailsViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/3/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class ShowCardDetailsViewController: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardRatingLabel: UILabel!
    @IBOutlet weak var cardDetailsTextView: UITextView!
    @IBOutlet weak var cardPricePerDayLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    var cardIDReceived = ""
    var serviceStatus: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Card Id recieved: ")
        print(cardIDReceived)
        self.showCardDetails()
        self.title = "Card Details"
    }
    

    func showCardDetails () {
        let cardIDConverted = Int(cardIDReceived)
        cardDetailsTextView.isEditable = false
        
        let param = ["id" : cardIDConverted!,
                     "api_key" : API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/cards/ByID", method: .post, parameters: param).validate().responseJSON {
            response in
            
            if ((response.result.value) != nil) {
                do {
                    let getCardByCardIDResponse = try JSONDecoder().decode(CardByID.self, from: response.data!)
                    let cardTitle = getCardByCardIDResponse.data[0].card_title
                    let cardDescription = getCardByCardIDResponse.data[0].card_description
                    let cardRating = getCardByCardIDResponse.data[0].card_average_rating
                    let cardPricePerDay = getCardByCardIDResponse.data[0].price_per_day
                    self.serviceStatus = getCardByCardIDResponse.data[0].service_status
                    
                    // If the Card is engaged then change the button color to light gray
                    if (self.serviceStatus == 1) {
                        self.editButton.backgroundColor = UIColor.lightGray
                    }
                    
                    //print(getCardByCardIDResponse)
                    
                    // Show in the UI
                    self.cardTitleLabel.text = cardTitle
                    self.cardDetailsTextView.text = cardDescription
                    self.cardPricePerDayLabel.text = "$" + String(cardPricePerDay!) + "/Day"
                    self.cardRatingLabel.text = String(cardRating ?? 0)
                    
                } catch {
                    print("Error while parsing Json for GetCardByCardID")
                }
            }
        }
    }

    @IBAction func editButtonTapped(_ sender: Any) {
        if (serviceStatus == 1) {
            displayAlertMessage("The Card is engaged!", "You are currently Providing Service with this card")
        } else if (serviceStatus == 0) {
            displayAlertMessage("Under Construction", "Edit feature is not available right now")
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
