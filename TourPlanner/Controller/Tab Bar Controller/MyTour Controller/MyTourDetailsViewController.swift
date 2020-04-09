//
//  MyTourDetailsViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/9/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class MyTourDetailsViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var pricePerDay: UILabel!
    @IBOutlet weak var touristName: UILabel!
    @IBOutlet weak var touristCountry: UILabel!
    
    var cardIDReceived = ""
    var touristIDReceived = ""
    var relationIDReceived = ""
    var guideIDReceived: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n========= My Tour Details View ===========")
        print("Relation ID: \(relationIDReceived)")
        print("Card ID: \(cardIDReceived)")
        print("Tourist ID \(touristIDReceived)")
        print("Guide ID: \(String(describing: guideIDReceived))")
        self.showRequestDetials()
        self.title = "Tour Details"
    }
    
    func showRequestDetials () {
        
        let getCardParam = ["id": cardIDReceived,
                     "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/cards/ByID", method: .post, parameters: getCardParam).validate().responseJSON {
            response in
            
            do {
                let getCardDetails = try JSONDecoder().decode(CardByID.self, from: response.data!)
                self.cardTitle.text = getCardDetails.data[0].card_title
                self.cardImageView.image = UIImage(named: "StaticImage2")
                self.pricePerDay.text = "$" + String(getCardDetails.data[0].price_per_day ?? 0) + "/Day"
            } catch {
                print("Error While parsing Card Details json")
            }
        }
        
        let getTouristParam = ["id": touristIDReceived,
                               "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/tourist/Profile", method: .post, parameters: getTouristParam).validate().responseJSON {
            response in
            
            do {
                let getTouristDetails = try JSONDecoder().decode(TouristProfile.self, from: response.data!)
                self.touristName.text = (getTouristDetails.data[0].first_name ?? "Not") + " " + (getTouristDetails.data[0].last_name ?? "Found")
                self.touristCountry.text = getTouristDetails.data[0].country ?? "Not Found"
            } catch {
                print("Error while parsing tourist profile details json")
            }
        }
    }
}
