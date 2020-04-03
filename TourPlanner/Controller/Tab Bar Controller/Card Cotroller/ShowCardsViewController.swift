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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Id in show card")
        print(id as Any)
        self.CardCollectionView!.reloadData()
        self.getCardsByGuideID()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createCardViewController = segue.destination as? CreateCardViewController {
            createCardViewController.id = id
        }
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
                    for card in getCardByGuideResponse.data {
                        self.cardID.append(String(card.id!))
                        self.cardTitle.append(String(card.card_title!))
                        self.cardPrice.append(String(card.price_per_day!))
                        if (self.cardTitle.count > 0) {
                            self.CardCollectionView!.reloadData()
                        }
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
        return forCardCell
    }

}
