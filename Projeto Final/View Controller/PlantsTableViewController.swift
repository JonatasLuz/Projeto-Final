//
//  PlantsTableViewController.swift
//  Projeto Final
//
//  Created by ALUNO on 22/04/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class PlantsTableViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    var plantsTableViewModel : PlantsTableViewModel!
    let cellIdentifier = "cell"
    var plants : [Plant]!
    
    override func viewDidLoad() {
       
        
        
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        plants = []
        plantsTableViewModel = PlantsTableViewModel()
        plantsTableViewModel.getPlants { plantsArray in
            self.plants = plantsArray
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlantsTableViewCell
        cell?.plantNameLabel.text = plants[indexPath.row].name
        cell?.plantImage.image =  plantsTableViewModel.getPlantImageURL(plants[indexPath.row].photo)
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plantIdentfier"{
            let next = segue.destination as! PlantViewController
            let row = tableView.indexPathForSelectedRow?.row
            next.plant = plants![row!]
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


}
