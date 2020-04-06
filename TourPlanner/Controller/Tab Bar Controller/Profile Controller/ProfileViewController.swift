//
//  ProfileViewController.swift
//  TourPlanner
//
//  Created by Sudipto Roy on 4/6/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var guide_id: Int?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\nGuide ID in ProfileViewController: \(String(describing: guide_id))")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
