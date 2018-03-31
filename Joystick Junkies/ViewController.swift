//
//  ViewController.swift
//  Joystick Junkies
//
//  Created by student on 2/15/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var fNameTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var contactNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
    
    var model = AppDelegate.model
    
    
    
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        
    
       let (a,b) = model.veifyRegistration(fName: fNameTF.text!, lName: lNameTF.text!, city: cityTF.text!, contact: contactNumberTF.text!, email: emailTF.text!, password: passwordTF.text!, confirmPassword: confirmPassword.text!)
        if !a {
        
                 let alert = UIAlertController(title: "Alert", message: b , preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .cancel) { action in
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true){
                        () in print("alert triggered \(b)")
                    }
        
        }else{
            
           let user = PFUser()
            user.username = emailTF.text!
            //usernameTF.text!
            user.password = passwordTF.text!
            user.email = emailTF.text!
            user["firstName"] = fNameTF.text!
            user["lastName"] = lNameTF.text!
            user["city"] = cityTF.text!
            user["contactNumber"] = contactNumberTF.text!
            user["confirmPassword"] = confirmPassword.text!
            
            
            
            user.signUpInBackground(block: {
                (success, error) -> Void in
                if let error = error as Error? {
                    let errorString = error.localizedDescription// In case something went wrong, use errorString to get the error
                    self.displayOKAlert(title: "Something has gone wrong", message:"\(errorString)")
                    
                } else { // Everything went okay
                    self.displayOKAlert(title: "Success!", message:"Registration was successful")
                    let emailVerified = user["emailVerified"]
                    if emailVerified != nil && (emailVerified as! Bool) == true { // Everything is fine
                        
                    } else { // The email has not been verified, so logout the user
                        PFUser.logOut()
                        
                    }
                    
                }
                
            })
            
            
            
            
            
        }
        
        
    }
    
    
    
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",          style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

