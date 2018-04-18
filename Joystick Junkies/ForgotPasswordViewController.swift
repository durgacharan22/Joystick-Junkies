//
//  ForgotPasswordViewController.swift
//  Joystick Junkies
//
//  Created by student on 4/18/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var EmailIDTF: UITextField!
    
    @IBAction func ResetBTNClicked(_ sender: UIButton) {
        PFUser.requestPasswordResetForEmail(inBackground: EmailIDTF.text!) {
            (success, error) -> Void in
            
            if success {
                self.displayOKAlert(title: "Success", message: "Email is sent to \(self.EmailIDTF.text!)",success: true)

            }
            else {
                self.displayOKAlert(title: "Failure", message: (error?.localizedDescription)!, success: false)

            }
            
        }
    }
    func displayOKAlert(title: String, message: String,success:Bool) {
     //   print(message)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default , handler: { _ in
            if success {
            self.dismiss(animated: true)
            }
        })
        )
        self.present(alert, animated: true)
        
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
