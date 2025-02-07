//
//  HomeViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/1/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var rating: UILabel!
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id as Any)
        getGuideProfile()
    }
    
    
    func getGuideProfile() {
        
        let param = ["id" : id!,
                     "api_key": API.API_key] as [String: Any]
        
        Alamofire.request(API.baseURL + "/guides/ProfileSelf", method: .post, parameters: param).validate().responseJSON {
            response in
            
            print(response)
            
            // let loginResponseData = try JSONDecoder().decode(Guide.self, from: response.data!)
            do {
                
                let guideProfileResponse = try JSONDecoder().decode(GuideProfile.self, from: response.data!)
                let rating = guideProfileResponse.data[0].ratings
                print("Rating")
                print(rating!)
                let showRating: String? = String(format:"%f", rating!)
                let convertedRating = String(rating!)
                print(showRating!)
                if rating == 0.0000000 {
                    self.rating.text = "N/A"
                } else {
                    //self.ratingLabel.text = showRating
                    self.rating.text = convertedRating
                }
                
            } catch {
                print("Error While parsing")
            }
        }
    }
}
