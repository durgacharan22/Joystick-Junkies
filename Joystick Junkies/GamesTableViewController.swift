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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.action(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton

        let query = PFQuery(className:"Game")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.Games = objects as! [PFObject]
                self.tableView.reloadData()
            } else {
                print("error in games table view controller")
            }
            
        }
    }
    
    @objc func action(_ sender: UIBarButtonItem!){
        PFUser.logOut()
        dismiss(animated: true, completion: nil)
        print("\(String(describing: PFUser.current())) user logged out")
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let query = PFQuery(className:"Game")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.Games = objects!
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

        return cell
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
//            print((tableView.indexPathForSelectedRow?.row)!)
//            var a:Int = (tableView.indexPathForSelectedRow?.row)!
             let vc = segue.destination as! GameInfoViewController
            vc.game = Games[(tableView.indexPathForSelectedRow?.row)!]

        }
    }
 

}
