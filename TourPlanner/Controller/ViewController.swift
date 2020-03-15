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
        //let decoder = JSONDecoder()
        
        // Checking if the fields are empty
        if (userEmail == "" || userPassword == "") {
            
            let alert = UIAlertController(title: "Empty Credentials", message: "You Must Enter your email and password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if ( userEmail != "" && userPassword != "") {
            
            // User login info parameters using dictionary
            let loginDict = ["email" : userEmail!,
                             "password": userPassword!,
                             "api_key": API.API_key] as [String: Any]
            
            
            // Calling the api with the parameter
            Alamofire.request(API.baseURL + "/guides/login", method: .post, parameters: loginDict).validate().responseJSON {
                response in
                
                // Showing the response in log
                print(response)
                
                do {
                    //print("in do")
                    // let loginResponseData = try self.decoder.decode(Guide.self, from: response.data! )
                    let loginResponseData = try JSONDecoder().decode(Guide.self, from: response.data!)
                    let successMessage = loginResponseData.success
                    print(successMessage as Any)
                    
                } catch {
                    
                    print("Error While Parsing Json")
                    
                }
            }
        }
    }
}

