//
//  ShowCardsViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/2/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class ShowCardsViewController: UICollectionViewController {
    
    @IBOutlet weak var CardCollectionView: UICollectionView!
    var id: Int?
    var data = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Id in show card")
        print(id as Any)
        getCardsByGuideID()
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createCardViewController = segue.destination as? CreateCardViewController {
            createCardViewController.id = id
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    func getCardsByGuideID () {
        let param = ["id": id as Any,
                     "api_key": API.API_key]
        
        Alamofire.request(API.baseURL + "/cards/ByGuideID", method: .post, parameters: param).validate().responseJSON {
            response in
            
            do {
                //let createCardResponse = try JSONDecoder().decode(CreateCard.self, from: response.data!)
                let getCardByGuideResponse = try JSONDecoder().decode(CardByGuide.self, from: response.data!)
                print(getCardByGuideResponse)
                
            } catch {
                print("Error While parsing Json")
            }
        }
    }

}
