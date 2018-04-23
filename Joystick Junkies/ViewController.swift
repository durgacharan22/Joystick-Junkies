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

        }
        // this method is invoked when view appear and checks for perform segue
        override func viewDidAppear(_ animated: Bool) {
            performSegue = false
        }
        
     
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // this field stores firstname textfield
        @IBOutlet weak var fNameTF: UITextField!
        
         // this field stores city textfield
        @IBOutlet weak var cityTF: UITextField!
        
         // this field stores contact number textfield
        @IBOutlet weak var contactNumberTF: UITextField!
        
         // this field stores email textfield
        @IBOutlet weak var emailTF: UITextField!
        
         // this field stores password textfield
        @IBOutlet weak var passwordTF: UITextField!
        
         // this field stores confirm password textfield
        @IBOutlet weak var confirmPassword: UITextField!
        
         // this field stores lastname textfield
        @IBOutlet weak var lNameTF: UITextField!
        
        var model = AppDelegate.model
        
        var performSegue:Bool = false
        
        
        // this function is called whenever signup btn is clicked and checks for validation and register user to database
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
                        self.displayOKAlert(title: "Something has gone wrong", message:"\(errorString)",doSegue: false)
                        
                    } else {
                            // Everything went okay
                            self.displayOKAlert(title: "Success!", message:"Registration was successful",doSegue: true)
                    
                    
                            let emailVerified = user["emailVerified"]
                    
                            if emailVerified != nil && (emailVerified as! Bool) == true {
                                // Everything is fine
                            } else {
                                // The email has not been verified, so logout the user
                                PFUser.logOut()
                            }
                        
                        }
                   })
        
            }
            
            
        }
        
        
        // this method is used to generate alert with ok Action and performs segue if registration is successful
        func displayOKAlert(title: String, message: String, doSegue: Bool) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default , handler: { _ in
                if doSegue {
                   self.performSegue(withIdentifier: "RegistrationToLogin", sender: nil)
                }
            })
            )
            self.present(alert, animated: true)
            
        }
        
        
        
        // this method checks whether to perform segue or not
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            return identifier == "RegistrationToLogin" ? false : true
        }
        
        

    }

