//
//  GamesTableViewController.swift
//  Joystick Junkies
//
//  Created by student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Parse

class GamesTableViewController: UITableViewController {
    
    var Games:[PFObject] = []
    var genreid:String?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @objc func action(_ sender: UIBarButtonItem!){
        PFUser.logOut()
        self.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            let rightBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.action(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }else{
            self.navigationItem.rightBarButtonItem?.title = ""
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        let query = PFQuery(className:"Game")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.Games = []
                for ele in objects! {
                    let obj = ele["GenreID"] as! PFObject
                    if self.genreid != nil && self.genreid != "" && self.genreid != "All"{
                        
                    if obj.objectId! == self.genreid {
                        self.Games.append(ele)
                        }
                        
                    } else {
                    self.Games.append(ele)
                    }
                }
                
                self.tv?.reloadData()
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
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    var tv:UITableView?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        tv = tableView
        return Games.count
    }
    var timer = Timer()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        let game = Games[indexPath.row]
        let data = game["UploadedImage"] as! PFFile
        do {
         
        cell.gameImage.image = try UIImage(data: data.getData())
            cell.desc.text = game["Name"] as? String
            
        }catch {
            print("error image fetching games table view controller")
        }
        let endDate = game["EndTime"] as! Date
        var interval = endDate.timeIntervalSince(Date())
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            interval = interval - 1
            cell.EndTimeLBL.text = self.timeString(time: interval)
        })
        
        
        return cell
    }
 
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        if( hours > 0 || minutes > 0 || seconds > 0 ){
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
        else{     
            return "Bidding Closed"
        }
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "a" {
             let vc = segue.destination as! GameInfoViewController
            vc.game = Games[(tableView.indexPathForSelectedRow?.row)!]

        }
    }
 

}
