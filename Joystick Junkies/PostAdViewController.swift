//
//  PostAdViewController.swift
//  Joystick Junkies
//
//  Created by Student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class PostAdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gameGenre: UITextField!
    @IBOutlet weak var gamePrice: UITextField!
    @IBOutlet weak var descriptionLBL: UITextView!
    @IBOutlet weak var basebidLBL: UITextField!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            if gameName.text! != ""{
            AppDelegate.model.games.append(gameName.text!)
                
                let Game = PFObject(className: "Game")
                Game["Name"] = gameName.text!
                Game["Price"] = Int(gamePrice.text!)
                Game["Genre"] = gameGenre.text!
                Game["BaseBid"] = Int(basebidLBL.text!)
                Game["Time"] = Date()
                Game["Description"] = descriptionLBL.text!
                 Game.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        let alert = UIAlertController(title: "Success!", message: "Movie saved.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK",style: .default , handler: { _ in
                          
                        })
                        )
                        self.present(alert, animated: true)
                      //  self.displayOKAlert(title: "Success!", message:"Movie saved.")
                        
                    } else {
                        print(error)
                        
                    }
                    
                 })
                
                
                
                
          }
        }
        
    }
 

}
