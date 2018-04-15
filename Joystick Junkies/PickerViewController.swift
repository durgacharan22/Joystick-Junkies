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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.current() != nil {
            self.loginBTN.isHidden = true
            self.signUp.isHidden = true
        }else{
            self.loginBTN.isHidden = false
            self.signUp.isHidden = false
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            self.loginBTN.isHidden = true
            self.signUp.isHidden = true
        }else{
            self.loginBTN.isHidden = false
            self.signUp.isHidden = false
        }
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
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let genre = genres[row]
        return genre["Genre"] as! String
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
