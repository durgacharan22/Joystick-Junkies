//
//  LoginViewController.swift
//  Joystick Junkies
//
//  Created by student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    var model = AppDelegate.model
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLBL: UILabel!
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
     
        let (a,b):(Bool,String) = model.verifyLogin(email: emailTF.text!, password: passwordTF.text!)
        if !a {
            
                    let alert = UIAlertController(title: "Alert", message: b , preferredStyle: .alert)
            
            
                    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                       
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true){
                        () in print("alert triggered \(b)")
                    }
        }
        else {
            
            PFUser.logInWithUsername(
                inBackground: emailTF.text!, password: passwordTF.text!, block:{(user, error) -> Void in
                    if error != nil{ print(error)
                        self.errorLBL.text = "Username or Password is Wrong \n Please try again!"
                    } else { // Everything went alright
                        
                        let alert = UIAlertController(title: "Success", message: "Login successful", preferredStyle: .alert)
                        
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                             self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true){
                            () in print("alert triggered \(b)")
                        }
                           }
                    
                        })

        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "LoginSegue"{
            return false
            
        }
        return true
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
