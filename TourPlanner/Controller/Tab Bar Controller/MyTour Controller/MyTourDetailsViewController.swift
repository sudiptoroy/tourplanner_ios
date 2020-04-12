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
    
    // UIButton outlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    var accepted: Int?
    var completed: Int?
    var cancelledByGuide: Int?
    var cancelledByTourist: Int?
    
    
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
        self.buttonState()
        self.title = "Tour Details"
    }
    
    func buttonState () {
        let param = ["id": relationIDReceived,
                     "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/tourist/TouristGuideRelationByID", method: .post, parameters: param).validate().responseJSON {
            response in
            
            print("\nResponse in buttonState function")
            print(response)
            
            do {
                let getRelationData = try JSONDecoder().decode(TouristGuideRelation.self, from: response.data!)
                self.accepted = getRelationData.data[0].is_accepted
                self.cancelledByGuide = getRelationData.data[0].is_cancelled_by_guide
                self.cancelledByTourist = getRelationData.data[0].is_cancelled_by_tourist
                self.completed = getRelationData.data[0].is_complited
                
                // Set button color state
                if (self.cancelledByGuide == 1 || self.cancelledByTourist == 1 || self.completed == 1) {
                    self.cancelButton.backgroundColor = UIColor.lightGray
                    self.acceptButton.backgroundColor = UIColor.lightGray
                }
                if (self.accepted == 1) {
                    self.cancelButton.backgroundColor = UIColor.lightGray
                    self.acceptButton.backgroundColor = UIColor.lightGray
                }
            } catch {
                print("Error while parsing Json in buttonState function")
            }
        }
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
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        
        if (self.cancelledByTourist == 0 && self.cancelledByGuide == 0) {
            if (self.accepted == 0 && self.completed == 0) {
                displayAcceptAlert("Accept", "You are about to start the tour. Are you sure you want to accept the order?")
            } else if (self.accepted == 1 && self.completed == 0) {
                displayAlertMessage("Tour Already accepted", "The Tour has already been accepted and the tour is ongoing")
            } else if (self.completed == 1) {
                displayAlertMessage("Completed", "The Tour is already completed")
            }
        } else {
            displayAlertMessage("Tour Cancelled", "The tour has already been cancelled. You cannot accept the tour now.")
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        if (self.cancelledByGuide == 0 && self.cancelledByTourist == 0) {
            self.displayCancelAlert("Cancel", "Are you sure you want to cancel this request?")
        } else {
            self.displayAlertMessage("Cancelled Already", "The tour has already been cancelled")
        }
    }
    
    // Function for accept button popup
    func displayAcceptAlert(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        {
            action in
            print("Ok Pressed")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            action in
            print("Cancel Pressed")
        }
        
        userAlert.addAction(okAction)
        userAlert.addAction(cancelAction)
        self.present(userAlert, animated: true, completion: nil)
    }
    
    // Function for cancel button popup
    func displayCancelAlert(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        {
            action in
            print("Ok Pressed")
            self.cancelRequest()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            action in
            print("Cancel Pressed")
        }
        
        userAlert.addAction(okAction)
        userAlert.addAction(cancelAction)
        self.present(userAlert, animated: true, completion: nil)
    }
    
    // Cancel request function
    func cancelRequest() {
        print("\nCancel Function Called")
        
        let param = ["id": relationIDReceived,
                     "is_accepted": 0,
                     "is_complited": 0,
                     "is_cancelled_by_tourist": 0,
                     "is_cancelled_by_guide": 1,
                     "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/tourist/updateTouristGuideRelation", method: .post, parameters: param).validate().responseJSON {
            response in
            
            print(response)
            
            do {
                let cancelResponse = try JSONDecoder().decode(TouristGuideCancel.self, from: response.data!)
                let success = cancelResponse.success
                if (success!) {
                    self.displayAlertMessage("Request Cancelled", "You've cancelled the tour request.")
                } else {
                    print("Error in success check")
                }
            } catch {
                print("Error while parsing JSON of cancel response")
            }
        }
    }
    
    // Display alert message
    func displayAlertMessage(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        userAlert.addAction(okAction)
        present(userAlert, animated: true, completion: nil)
    }
}
