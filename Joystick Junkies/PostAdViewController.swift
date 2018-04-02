//
//  PostAdViewController.swift
//  Joystick Junkies
//
//  Created by Student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class PostAdViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gameGenre: UITextField!
    @IBOutlet weak var gamePrice: UITextField!
    @IBOutlet weak var descriptionLBL: UITextView!
    @IBOutlet weak var basebidLBL: UITextField!
    @IBAction func uploadImages(_ sender: Any) {
        
        let picker = UIImagePickerController()
         picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo: [String:Any]) {
        print(didFinishPickingMediaWithInfo)
        var selectedImage:UIImage?
        
        
        if let editedImage = didFinishPickingMediaWithInfo["UIImagePickerControllerEditedImage"] as? UIImage {
            print(editedImage.size)
            selectedImage = editedImage
        }
        
        if let originalImage = didFinishPickingMediaWithInfo["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
            selectedImage = originalImage
        }
        
        if let finalImage = selectedImage {
            
            dismiss(animated: true, completion: nil)
            self.selectedImage.image = finalImage
            
         
            
            
        }
        
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            if gameName.text! != ""{
                
                AppDelegate.model.games.append(gameName.text!)
                
                let Game = PFObject(className: "Game")
                let Genre = PFObject(className: "Genre")
                Game["Name"] = gameName.text!
                Game["Price"] = Int(gamePrice.text!)
                Genre["Genre"] = gameGenre.text!
                Game["BaseBid"] = Int(basebidLBL.text!)
                Game["Time"] = Date()
                Game["Description"] = descriptionLBL.text!
                let PNGImage = UIImagePNGRepresentation(self.selectedImage.image!)
                Game["UploadedImage"] = PFFile(name: self.gameName.text!, data: PNGImage!)
                Genre.saveInBackground(block: { (success,error) -> Void in
                    if success {
                        let query = PFQuery(className: "Genre")
                        query.whereKey("Genre", equalTo: self.gameGenre.text!)
                        do {
                         let obj = try query.getFirstObject()
                            
                            Game["GenreID"] = obj
                        } catch {
                            print(error)
                        }
                        
                        Game.saveInBackground(block: { (success, error) -> Void in
                            if success {
                                print("Success")
                            } else {
                                print("-----------------\(String(describing: error))")
                                
                            }
                            
                        })
                        
                        
                    }else {
                        print(error)
                    }
                })
                
          }
        }
        
    }

    ///
 

}
