//
//  ViewController.swift
//  Joystick Junkies
//
//  Created by student on 2/15/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeview(_ sender: Any) {
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabviewcontroller")
        let appdelegate =  UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = tabBarController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

