//
//  GardenCollectionViewController.swift
//  Projeto Final
//
//  Created by Guest User on 23/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit
import SideMenu

private let reuseIdentifier = "plantIdentifier"

class GardenCollectionViewController: UICollectionViewController {
    var gardenViewModel = GardenViewModel()
    var plants:[Plant]!
    var user : User!
    var achievements: [Achievement]!

    override func viewDidLoad() {        
        super.viewDidLoad()
        
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return user.myGarden.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GardenCollectionViewCell
        let plant = plants.first(where: {$0.plantID == user.myGarden[indexPath.row].plantId})
        
        cell.plantImage.image = plant?.photo
        cell.namePlant.text = plant?.name
        cell.plantingDate.text = "Plantio: " + user.myGarden[indexPath.row].plantedDate
        cell.harvestMinMonth.text = "Inico:" + user.myGarden[indexPath.row].harvestMinLimit
        cell.harvestMaxMonth.text = "Fim: " + user.myGarden[indexPath.row].harvestMaxLimit
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let plantViewModel = PlantViewModel()
        let plantDate = user.myGarden[indexPath.row].plantedDate
        let harvestMinDate = user.myGarden[indexPath.row].harvestMinLimit
        let harvestMaxDate = user.myGarden[indexPath.row].harvestMaxLimit
        let checkHarvest = gardenViewModel.checkMinHarvestDate(harvestMinDate!)
        
        
        let alert = UIAlertController(title: "Minha Horta", message: "", preferredStyle: .alert)
        
        let harvestButton = UIAlertAction(title: "Marcar como colhida", style:.default) { (UIAlertAction) in
            plantViewModel.harvestPlant(indexPath.row, self.user)
            plantViewModel.removeGardenPlant(indexPath.row, self.user)
            collectionView.reloadData()
        }
        
        let removeButton = UIAlertAction(title: "Remover Planta", style: .destructive) { (UIAlertAction) in
            plantViewModel.removeGardenPlant(indexPath.row, self.user)
            collectionView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in}
        alert.addAction(harvestButton)
        alert.addAction(removeButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuIdentifier"{
            
            if let navView = segue.destination as? UISideMenuNavigationController{
                let next = navView.topViewController as! MenuTableViewController
                next.plants = plants
                next.user = user
                next.achievements = achievements
            }
        }
    }
    
}
extension GardenCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
    }
}


