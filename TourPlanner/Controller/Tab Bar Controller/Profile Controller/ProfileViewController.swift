//
//  ProfileViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/6/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    var guide_id: Int?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\nGuide ID in ProfileViewController: \(String(describing: guide_id))")
        self.showProfile()
        // Do any additional setup after loading the view.
    }
    
    func  showProfile() {
        
        let param = ["id" : guide_id!,
                     "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/guides/ProfileSelf", method: .post, parameters: param).validate().responseJSON {
            response in
            
            do {
                let guideProfileResponse = try JSONDecoder().decode(GuideProfile.self, from: response.data!)
                let firstName = guideProfileResponse.data[0].first_name
                let lastName = guideProfileResponse.data[0].last_name
                let rating = guideProfileResponse.data[0].ratings
                let gender = guideProfileResponse.data[0].gender
                
                if (gender == "male") {
                    self.profileImageView.image = UIImage(named: "ProfileMale")
                } else if (gender == "female") {
                    self.profileImageView.image = UIImage(named: "ProfileFemale")
                }
                
                self.profileName.text = firstName! + " " + lastName!
                self.rating.text = String(rating ?? 0.0)
                
                
            } catch {
                print("Error while parsing profile json data. Check it again")
            }
        }
    }
}
