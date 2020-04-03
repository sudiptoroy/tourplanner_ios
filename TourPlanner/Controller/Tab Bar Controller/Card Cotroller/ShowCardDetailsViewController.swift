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
    
    
    var cardIDReceived = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Card Id recieved: ")
        print(cardIDReceived)
        self.showCardDetails()
        // Do any additional setup after loading the view.
    }
    

    func showCardDetails () {
        let cardIDConverted = Int(cardIDReceived)
        
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
}
