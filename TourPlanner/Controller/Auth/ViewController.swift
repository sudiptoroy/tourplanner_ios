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
    
    var check = false
    var guide_id = 0
    
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
            
            // Check if the email is valid
            if (isValidEmail(email: userEmail!)){
                
                // User login info parameters using dictionary
                let loginDict = ["email" : userEmail!,
                                 "password": userPassword!,
                                 "api_key": API.API_key] as [String: Any]
                
                // Calling the api with the parameter
                Alamofire.request(API.baseURL + "/guides/login", method: .post, parameters: loginDict).validate().responseJSON {
                    response in
                    
                    // Showing the response in log
                    print(response)
                    
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print("Success =")
                        print(JSON["success"]!)
                        self.check = JSON["success"] as! Bool
                        //let check = Bool(JSON["success"])!
                        print(self.check)
                    }
                    
                    if (!self.check) {
                        self.displayAlertMessage("Invalid Credentials", "Please enter correct email and password")
                    } else if (self.check) {
                        do {
                            // let loginResponseData = try self.decoder.decode(Guide.self, from: response.data! )
                            let loginResponseData = try JSONDecoder().decode(Guide.self, from: response.data!)
                            let successMessage = loginResponseData.success
                            let isVerified = loginResponseData.data[0].is_verified
                            let id = loginResponseData.data[0].id
                            self.guide_id = id!
                            print(isVerified!)
                            print(id!)
                            
                            print(successMessage as Any)
                            
                            if (successMessage == true) {
                                
                                if (isVerified == 0) {
                                    self.dismiss(animated: true, completion: nil)
                                    self.performSegue(withIdentifier: "PendingView", sender: self)
                                } else if (isVerified == 1) {
                                    self.dismiss(animated: true, completion: nil)
                                    self.performSegue(withIdentifier: "TabBarView", sender: self)
                                }
                            }
                        } catch {
                            print("Error While Parsing Json")
                        }
                    }
                    
                }
            } else {
                displayAlertMessage("Invalid email", "Your email address is not valid")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainTabBarController = segue.destination as? MainTabBarController {
            mainTabBarController.id = guide_id
        }
    }
    
    // Function to display alert message
    func displayAlertMessage(_ title: String,_ userMessage: String) {
        let userAlert = UIAlertController(title: title, message:  userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        userAlert.addAction(okAction)
        self.present(userAlert, animated: true, completion: nil)
    }
    
    // Function to verify valid email address
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

