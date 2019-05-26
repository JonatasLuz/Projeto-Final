//
//  ToolTableViewController.swift
//  Projeto Final
//
//  Created by Guest User on 26/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit
import SideMenu

class ToolTableViewController: UITableViewController {
    let toolViewModel = ToolViewModel()
    var tools = [Tool]()
    var achievements = [Achievement]()
    var user : User!
    var plants = [Plant]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tools.count == 0{
            toolViewModel.getTools { toolArray in
                self.tools = toolArray
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tools.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toolIdentifier", for: indexPath) as! ToolTableViewCell
        cell.nameLabel.text = tools[indexPath.row].name
        cell.toolImageView.image = tools[indexPath.row].photo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title:tools[indexPath.row].name, message: tools[indexPath.row].description, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in}
        alert.addAction(okButton)
        self.present(alert,animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuIdentifier"{
            if let navView = segue.destination as? UISideMenuNavigationController{
                let next = navView.topViewController as! MenuTableViewController
                next.plants = plants
                next.user = user
                next.achievements = achievements
                next.tools = tools
            }
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
