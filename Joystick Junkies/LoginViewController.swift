//
//  LoginViewController.swift
//  Joystick Junkies
//
//  Created by student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

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
