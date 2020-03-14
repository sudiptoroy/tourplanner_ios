//
//  ViewController.swift
//  TourPlanner
//
//  Created by Farisa on 2/26/20.
//  Copyright © 2020 Code_x. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        
        if (userEmail == "" || userPassword == "") {
            
            let alert = UIAlertController(title: "Empty Credentials", message: "You Must Enter your email and password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
    }
}

