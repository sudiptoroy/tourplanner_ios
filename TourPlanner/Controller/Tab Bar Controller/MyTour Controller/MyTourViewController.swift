//
//  MyTourViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/7/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class MyTourViewController: UIViewController {
    
    var guide_id: Int?
    var check = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n========= My Tour =============")
        print("\n Guide ID in My tour View: \(String(describing: guide_id))")
        self.getTourGuideRelationByGuideID()
    }
    
    
    func getTourGuideRelationByGuideID () {
    
        let param = ["guide_id": guide_id!,
                     "api_key": API.API_key] as [String : Any]
        
        // Calling toursitGuideRelation api by Guide ID
        Alamofire.request(API.baseURL + "/tourist/TouristGuideRelationByGuideID", method: .post, parameters: param).validate().responseJSON {
            response in
            
            print(response)
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print("\nSuccess = \(JSON["success"]!)")
                self.check = JSON["success"] as! Bool
                print("\ncheck: \(self.check)")
            }
            
            if (self.check == true) {
                do {
                    // let getCardByGuideResponse = try JSONDecoder().decode(CardByGuide.self, from: response.data!)
                    let getTouristGuideRelation = try JSONDecoder().decode(TouristGuideRelation.self, from: response.data!)
                    
                    for relation in getTouristGuideRelation.data {
                        print(relation.is_accepted!)
                    }
                    
                } catch {
                    print("Error while parsing json of Tourist Guide relation api response")
                }
            }
        }
    }
}
