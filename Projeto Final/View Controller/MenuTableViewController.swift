//
//  MenuTableViewController.swift
//  Projeto Final
//
//  Created by Guest User on 25/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var user : User!
    var plants : [Plant]!
    var achievements: [Achievement]!
    var tools : [Tool]!
    @IBOutlet weak var profileWC: NSLayoutConstraint!
    @IBOutlet weak var TipsWC: NSLayoutConstraint!
    @IBOutlet weak var myGardenWc: NSLayoutConstraint!

    @IBOutlet weak var toolsWC: NSLayoutConstraint!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var myGardenButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    
    @IBOutlet weak var toolButton: UIButton!
    
    override func viewDidLoad() {
        
        tableView.backgroundColor = UIColor(red:0.00, green:0.56, blue:0.32, alpha:1.0)
        profileWC.constant = view.frame.width/2
        TipsWC.constant = view.frame.width/2
        myGardenWc.constant = view.frame.width/2
        toolsWC.constant = view.frame.width/2
        
        toolButton.layer.cornerRadius = toolButton.frame.height / 2.5
        profileButton.layer.cornerRadius = profileButton.frame.height/2.5
        tipsButton.layer.cornerRadius = tipsButton.frame.height/2.5
        myGardenButton.layer.cornerRadius = myGardenButton.frame.height/2.5
        
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileIdentifier"{
            let next = segue.destination as! ProfileViewController
            next.plants = plants
            next.achievements = achievements
            next.userInfo = user
        }
        if segue.identifier == "myGardenIdentifer"{
            let next = segue.destination as! GardenCollectionViewController
            next.plants = plants
            next.achievements = achievements
            next.user = user
        }
        if segue.identifier == "toolIdentifier"{
            let next = segue.destination as! ToolTableViewController
            next.user = user
            next.plants = plants
            next.achievements = achievements
            if tools != nil{
                next.tools = tools
            }
        }
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
