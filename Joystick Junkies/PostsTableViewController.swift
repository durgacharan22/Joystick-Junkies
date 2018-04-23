//
//  PostsTableViewController.swift
//  Joystick Junkies
//
//  Created by Bonala,Santhosh on 4/22/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

import Parse

class PostsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var Games:[PFObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let query1 = PFQuery(className:"Game")
        
        query1.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.Games = []
                for ele in objects! {
                    let obj = ele["SellerInfo"] as! PFObject
                    
                    if obj.objectId! == PFUser.current()?.objectId {
                        self.Games.append(ele)
                    }
                }
             self.tableView.reloadData()
                
            } else {
                print("error in games table view controller")
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        

        return Games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostTableViewCell
        
        cell.postname?.text = Games[indexPath.row]["Name"] as! String
        cell.postBaseBid?.text = "\(Games[indexPath.row]["BaseBid"]!)"
        let data = Games[indexPath.row]["UploadedImage"] as! PFFile
        do {
           
            cell.postImage?.image = try UIImage(data: data.getData())
 



        }catch {
            print("error image fetching games table view controller")
        }

        return cell
    }
    
    var index = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        
        self.performSegue(withIdentifier: "PostsToPost", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let vc = segue.destination as! PostViewController
        vc.post = Games[index]
    }
 

}
