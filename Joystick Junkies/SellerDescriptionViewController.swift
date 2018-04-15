//
//  SellerDescriptionViewController.swift
//  Joystick Junkies
//
//  Created by Student on 4/14/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class SellerDescriptionViewController: UIViewController {

    @IBOutlet weak var phonenumberLBL: UILabel!
    @IBOutlet weak var emailIDLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    var data:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLBL.text = "\(data[0]) \(data[1])"
        emailIDLBL.text = data[2]
        phonenumberLBL.text = data[3]
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
