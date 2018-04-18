//
//  PickerViewController.swift
//  Joystick Junkies
//
//  Created by Student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class PickerViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var LogoutBTN: UIButton!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func LogoutBTNClicked(_ sender: Any) {
        PFUser.logOut()
        self.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className:"Genre")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.genres = objects as! [PFObject]
                self.pv?.reloadAllComponents()
                
            } else {
                print("error in picker table view controller")
            }
            
        }
    }
    
    @IBOutlet weak var signUp: UIButton!
    
    var genres:[PFObject] = []
    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            self.loginBTN.isHidden = true
            self.signUp.isHidden = true
            self.LogoutBTN.isHidden = false
        }else{
            self.loginBTN.isHidden = false
            self.signUp.isHidden = false
            self.LogoutBTN.isHidden = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
     
        let query = PFQuery(className:"Genre")
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.genres = objects as! [PFObject]
                self.pv?.reloadAllComponents()
            
            } else {
                print("error in picker table view controller")
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var pv:UIPickerView?
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pv = pickerView
        return genres.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if genres.count != row {
        let genre = genres[row]
        return genre["Genre"] as? String
        }
        return "All"
    }
    
    var selectedGenre = ""
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(genres)
        if genres.count != row {
        selectedGenre = genres[row].objectId!
        }else {
            selectedGenre = "All"
        }
        
        print(selectedGenre)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickerToGames" {
        let vc = segue.destination as! UINavigationController
            let v = vc.childViewControllers[0] as! GamesTableViewController
            v.genreid = selectedGenre
            print("\(selectedGenre) selected genre")
        }
    }
 

}
