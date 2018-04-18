//
//  SellerDescriptionViewController.swift
//  Joystick Junkies
//
//  Created by Student on 4/14/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse
class SellerDescriptionViewController: UIViewController {

    @IBOutlet weak var phonenumberLBL: UILabel!
    @IBOutlet weak var emailIDLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    var data:[String] = []
    
    
    @IBAction func LogoutBTNClicked(_ sender: Any) {
        PFUser.logOut()
        self.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLBL.text = "\(data[0]) \(data[1])"
        emailIDLBL.text = data[2]
        phonenumberLBL.text = data[3]
    }
    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current() == nil {
            self.navigationItem.rightBarButtonItem?.title = "";
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Logout";
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
