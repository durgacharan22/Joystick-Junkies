//
//  PostViewController.swift
//  Joystick Junkies
//
//  Created by Bonala,Santhosh on 4/22/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    var post:PFObject?
    
    @IBOutlet weak var descriptionTF: UITextField!
    
    
    @IBOutlet weak var basebidTF: UITextField!
    
    
    @IBOutlet weak var priceTF: UITextField!
    
    
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        descriptionTF.text = post?["Description"] as? String
        let basebid = post?["BaseBid"]
        basebidTF.text = "\(String(describing: basebid!))"
        let price = post?["Price"]
        priceTF.text = "\(String(describing: price!))"
        nameTF.text = (post?["Name"] as! String)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        post?["Description"] = descriptionTF.text!
        post?["BaseBid"] = Int(basebidTF.text!)!
        post?["Price"] = Int(priceTF.text!)!
        post?["Name"]  = nameTF.text!
        
        post?.saveInBackground(block: {
            (success, error) -> Void in
            if success {
             print("success")
                
            } else {
                print(error)
                
            }
            
        })

    }

}
