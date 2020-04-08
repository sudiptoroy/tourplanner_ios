//
//  MyTourViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/7/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class MyTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTourTableView: UITableView!
    var guide_id: Int?
    var check = false
    
    var id = [String]()
    var cardID = [String]()
    var cardTitle = [String]()
    var cardPrice = [String]()
    var touristsID = [String]()
    var isAccepted = [String]()
    var isComplited = [String]()
    var isCancelledByTourist = [String]()
    var isCancelledByGuide = [String]()
    var createdAt = [String]()
    var updatedAt = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n========= My Tour =============")
        print("\n Guide ID in My tour View: \(String(describing: guide_id))")
        self.getTourGuideRelationByGuideID()
        myTourTableView.delegate = self
        myTourTableView.dataSource = self
        myTourTableView.reloadData()
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
            
            if (self.check) {
                do {
                    let getTouristGuideRelation = try JSONDecoder().decode(TouristGuideRelation.self, from: response.data!)
                    
                    self.id.removeAll()
                    self.cardID.removeAll()
                    self.cardTitle.removeAll()
                    self.cardPrice.removeAll()
                    self.touristsID.removeAll()
                    self.isAccepted.removeAll()
                    self.isComplited.removeAll()
                    self.isCancelledByTourist.removeAll()
                    self.isCancelledByGuide.removeAll()
                    self.createdAt.removeAll()
                    self.updatedAt.removeAll()
            
                    for relation in getTouristGuideRelation.data {
                        print(relation.card_id!)
                        self.cardID.append(String(relation.card_id!))
                        self.id.append(String(relation.id!))
                        print("Print ID count \(self.id.count)")
                        self.isAccepted.append(String(relation.is_accepted!))
                        self.isComplited.append(String(relation.is_complited!))
                        self.isCancelledByGuide.append(String(relation.is_cancelled_by_guide!))
                        self.isCancelledByTourist.append(String(relation.is_cancelled_by_tourist!))
                        self.createdAt.append(relation.created_at!)
                        self.updatedAt.append(relation.updated_at!)
                        
                        
                        
                        let param = ["id": relation.card_id!,
                                     "api_key": API.API_key] as [String : Any]
                        
                        Alamofire.request(API.baseURL + "/cards/ByID", method: .post, parameters: param).validate().responseJSON {
                            response in
                            
                            do {
                                let getCardDetails = try JSONDecoder().decode(CardByID.self, from: response.data!)
                                //print("Card Title = \(String(describing: getCardDetails.data[0].card_title))")
                                self.cardTitle.append(getCardDetails.data[0].card_title!)
                                self.cardPrice.append(String(getCardDetails.data[0].price_per_day!))
                                if (self.cardTitle.count > 0) {
                                    self.myTourTableView?.reloadData()
                                }
                            } catch {
                                print("Error while parsing json of card api response")
                            }
                        }
                    }
                } catch {
                    print("Error while parsing json of Tourist Guide relation api response")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTourTableViewCell", for: indexPath) as! MyTourTableViewCell
        
        cell.cardImage.image = UIImage(named: "StaticImage2")
        cell.cardTitle.text = cardTitle[indexPath.row]
        cell.price.text = cardPrice[indexPath.row]
        
        if (isAccepted[indexPath.row] == "0" && isComplited[indexPath.row] == "0") {
            cell.statusLabel.text = "Requested"
        } else if (isAccepted[indexPath.row] == "1" && isComplited[indexPath.row] == "0") {
            cell.statusLabel.text = "On Going"
        } else if (isComplited[indexPath.row] == "1") {
            cell.statusLabel.text = "Completed"
        } else if (isCancelledByTourist[indexPath.row] == "1" || isCancelledByGuide[indexPath.row] == "1") {
            cell.statusLabel.text = "Cancelled"
        }
        
        return cell
    }
}
