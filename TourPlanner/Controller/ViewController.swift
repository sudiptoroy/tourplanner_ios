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
        
        // Checking if the fields are empty
        if (userEmail == "" || userPassword == "") {
            self.displayAlertMessage("Empty Credentials", "You must Enter your email and password")
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
                    // let loginResponseData = try self.decoder.decode(Guide.self, from: response.data! )
                    let loginResponseData = try JSONDecoder().decode(Guide.self, from: response.data!)
                    let successMessage = loginResponseData.success
                    let isVerified = loginResponseData.data[0].is_verified
                    let id = loginResponseData.data[0].id
                    print(isVerified!)
                    print(id!)
                    
                    print(successMessage as Any)
                    
                    if (successMessage == true) {
                        
                        if (isVerified == 0) {
                            self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "PendingView", sender: self)
                        }
                    }
                } catch {
                    print("Error While Parsing Json")
                }
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON["success"]!)
                }
            }
        }
    }
    
    // Function to display alert message
    
    func displayAlertMessage(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        userAlert.addAction(okAction)
        self.present(userAlert, animated: true, completion: nil)
    }
}

