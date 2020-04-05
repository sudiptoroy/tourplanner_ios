//
//  ShowCardsViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class ShowCardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var CardCollectionView: UICollectionView!
    var id: Int?
    var cardID = [String]()
    var cardTitle = [String]()
    var cardPrice = [String]()
    var cardRating = [String]()
    var serviceStatus = [String]()
    var cardStatus = [String]()
    
    var cardIDForDetailsView = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Id in show card")
        print(id as Any)
        //self.CardCollectionView!.reloadData()
        self.getCardsByGuideID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
        //self.CardCollectionView!.reloadData()
        //getCardsByGuideID()
    }

    
    // ============== Get All Cards By Guide Id =====================
    
    func getCardsByGuideID () {
        let param = ["guide_id": id!,
                     "api_key": API.API_key] as [String: Any]
        
        // Calling getCardsByGuideID API
        Alamofire.request(API.baseURL + "/cards/ByGuideID", method: .post, parameters: param).validate().responseJSON {
            response in
            
            if ((response.result.value != nil)) {
                do {
                    let getCardByGuideResponse = try JSONDecoder().decode(CardByGuide.self, from: response.data!)
                    
                    // Empty array before appending
                    self.cardID.removeAll()
                    self.cardTitle.removeAll()
                    self.cardPrice.removeAll()
                    self.cardRating.removeAll()
                    self.serviceStatus.removeAll()
                    self.cardStatus.removeAll()
                    
                    for card in getCardByGuideResponse.data {
                        self.cardID.append(String(card.id!))
                        self.cardTitle.append(String(card.card_title!))
                        print("Card Title \(self.cardTitle)")
                        self.cardPrice.append(String(card.price_per_day!))
                        self.cardRating.append(String(card.card_average_rating ?? 0))
                        self.serviceStatus.append(String(card.service_status!))
                        self.cardStatus.append(String(card.card_status!))
                    }
                    
                    if (self.cardTitle.count > 0) {
                        self.CardCollectionView!.reloadData()
                    }
                    
                } catch {
                    print("Error While Card Json Data")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let forCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        forCardCell.cardTitle.text = cardTitle[indexPath.item]
        forCardCell.pricePerDay.text = "$" + cardPrice[indexPath.item] + "/day"
        forCardCell.cardRating.text = cardRating[indexPath.item]
        
        if (cardStatus[indexPath.item] == "1") {
            forCardCell.statusImage.image = UIImage(named: "Active")
        } else if (cardStatus[indexPath.item] == "0") {
            forCardCell.statusImage.image = UIImage(named: "Inactive")
        }
        
        // Set default label status
        forCardCell.serviceStatus.text = ""
        
        if (serviceStatus[indexPath.item] == "1") {
            forCardCell.serviceStatus.layer.cornerRadius = 8
            forCardCell.serviceStatus.text = "Engaged"
        }
        forCardCell.cardImage.image = UIImage(named: "StaticImage2")
        
        forCardCell.layer.cornerRadius = 8
        forCardCell.layer.borderColor = UIColor.lightGray.cgColor
        //forCardCell.layer.backgroundColor = UIColor.lightGray.cgColor
        forCardCell.layer.shadowColor = UIColor.lightGray.cgColor
        forCardCell.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        forCardCell.layer.shadowRadius = 2.0
        forCardCell.layer.shadowOpacity = 0.5
        return forCardCell
    }
    
    // Function to dectect selected card in row of collectionview
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(cardID[indexPath.row])
        cardIDForDetailsView = cardID[indexPath.row]
        self.performSegue(withIdentifier: "CardDetailsView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createCardViewController = segue.destination as? CreateCardViewController {
            createCardViewController.id = id
        }
        if (segue.identifier == "CardDetailsView") {
            let vc = segue.destination as! ShowCardDetailsViewController
            vc.cardIDReceived = self.cardIDForDetailsView
            vc.guidIDReceived = self.id
        }
    }
}
