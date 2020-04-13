//
//  TouristProfileViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/12/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class TouristProfileViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var touristName: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    
    var touristIDReceived = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n============= Touist Profile View ===============")
        print("Tourist Id Received: \(touristIDReceived)")
        self.showTouristProfile()
    }
    
    func showTouristProfile () {
        
        let param = ["id": touristIDReceived,
                     "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/tourist/Profile", method: .post, parameters: param).validate().responseJSON {
            response in
            
            print(response)
            
            do {
                let getTouristProfile = try JSONDecoder().decode(TouristProfile.self, from: response.data!)
                self.coverImage.image = UIImage(named: "StaticImage")
                if (getTouristProfile.data[0].gender == "Male") {
                    self.profileImage.image = UIImage(named: "ProfileMale")
                } else if (getTouristProfile.data[0].gender == "Female") {
                    self.profileImage.image = UIImage(named: "ProfileFemale")
                } else {
                    self.profileImage.image = UIImage(named: "ProfileMale")
                }
                
                self.touristName.text = (getTouristProfile.data[0].first_name ?? "Not") + " " + (getTouristProfile.data[0].last_name ?? "Found")
                self.country.text = getTouristProfile.data[0].country ?? "Not Found"
                self.gender.text = getTouristProfile.data[0].gender ?? "Not Found"
                self.dateOfBirth.text = getTouristProfile.data[0].date_of_birth ?? "Not Found"
            } catch {
                print("Error while parsing tourist profile json data")
            }
        }
    }
}
