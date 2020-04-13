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
    var guidIDReceived : Int?
    var cardTitle: String?
    var cardDescription: String?
    var cardPricePerDay: Int?
    var placeIDs: String?
    var cardRating: Double?
    var serviceStatus: Int?
    var cardStatus: Int?
    var cardTags: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Card Id recieved: ")
        print(cardIDReceived)
        print("Guide Id received")
        print(guidIDReceived as Any)
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
                    self.cardImage.image = UIImage(named: "StaticImage2")
                    self.cardTitle = getCardByCardIDResponse.data[0].card_title
                    self.cardDescription = getCardByCardIDResponse.data[0].card_description
                    self.cardRating = getCardByCardIDResponse.data[0].card_average_rating
                    self.cardPricePerDay = getCardByCardIDResponse.data[0].price_per_day
                    self.placeIDs = getCardByCardIDResponse.data[0].place_ids
                    self.serviceStatus = getCardByCardIDResponse.data[0].service_status
                    self.cardStatus = getCardByCardIDResponse.data[0].card_status
                    self.cardTags = getCardByCardIDResponse.data[0].card_category_tags
                    // If the Card is engaged then change the button color to light gray
                    if (self.serviceStatus == 1) {
                        self.editButton.backgroundColor = UIColor.lightGray
                    }
                    
                    //print(getCardByCardIDResponse)
                    
                    // Show in the UI
                    self.cardTitleLabel.text = self.cardTitle
                    self.cardDetailsTextView.text = self.cardDescription
                    self.cardPricePerDayLabel.text = "$" + String(self.cardPricePerDay!) + "/Day"
                    self.cardRatingLabel.text = String(self.cardRating ?? 0)
                    
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
            self.performSegue(withIdentifier: "EditCardView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditCardView") {
            let vc = segue.destination as! EditCardViewController
            vc.cardIDReceived = self.cardIDReceived
            vc.guideIDReceived = self.guidIDReceived
            vc.cardTitleReceived = self.cardTitle
            vc.cardDescriptionReceived = self.cardDescription
            vc.pricePerDayReceived = self.cardPricePerDay
            vc.placeIDsReceived = self.placeIDs
            vc.serviceStatusReceived = self.serviceStatus
            vc.cardStatusReceived = self.cardStatus
            vc.cardTagsReceived = self.cardTags
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
