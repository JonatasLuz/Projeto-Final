//
//  ProfileViewController.swift
//  Projeto Final
//
//  Created by Guest User on 13/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit


let profileCell = "harvestCell"
class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var wantCollection: UICollectionView!
    @IBOutlet weak var harvestCollection: UICollectionView!
 
    
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    var userInfo : User!
    var plants : [Plant]!
    var plantSelected : String!
    
    @IBOutlet weak var myGardenButton: UIButton!
 
    
    override func viewDidLoad() {
        profileNameLabel.text = userInfo.firstName
        
        myGardenButton.layer.cornerRadius = 0.5 * myGardenButton.bounds.size.height
        myGardenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myGardenButton.clipsToBounds = true
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(userInfo.planted.count)
        self.reloadInputViews()
        self.harvestCollection.reloadData()
    }
    
    @IBAction func myGarden(_ sender: UIButton) {
        performSegue(withIdentifier: "gardenIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gardenIdentifier"{
            let next = segue.destination as! GardenCollectionViewController
            next.plants = plants
            next.user = userInfo
        }
        if segue.identifier == "plantIdentifier"{
            let next = segue.destination as! PlantViewController
            next.plantSelected = plants.firstIndex(where: {$0.plantID == plantSelected})
            next.plants = plants
            next.userInfo = userInfo
        }
    }
}


extension ProfileViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView ==  self.wantCollection{
            return userInfo.wantList.count
            
        }else if collectionView == self.harvestCollection{
            print(userInfo.planted.count)
            
            return userInfo.planted.count
        }
        return userInfo.myAchievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.harvestCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "harvestCell", for: indexPath) as! HarvestCollectionViewCell
            let plant = plants.first(where: {$0.plantID == self.userInfo.planted[indexPath.row]})
            cell.plantImageView.image = plant?.photo
            cell.plantNameLabel.text = plant?.name
            print("Constraint")
            print( cell.plantImageView.constraints)
            cell.plantImageView.layer.borderColor = cell.plantNameLabel.textColor.cgColor
            return cell
        }else if collectionView == self.wantCollection{
            let plant = plants.first(where: {$0.plantID == self.userInfo.wantList[indexPath.row]})
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wantCell", for: indexPath) as! WantCollectionViewCell
            cell.plantImageView.image = plant?.photo
            cell.plantNameLabel.text = plant?.name
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievement", for: indexPath)
            return cell
        }
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let plantViewModel = PlantViewModel()
        if collectionView == self.wantCollection{
            let alert = UIAlertController(title: "Quero Plantar", message: "O que deseja fazer?", preferredStyle: .alert)
            let plantInfoButton = UIAlertAction(title: "Ver Planta", style: .default) { (UIAlertAction) in
                self.plantSelected = self.userInfo.wantList[indexPath.row]
                self.performSegue(withIdentifier: "plantIdentifier", sender: self)
                
            }
            let plantButton = UIAlertAction(title: "Plantar", style: .default) { (UIAlertAction) in
                let plant = self.plants.first(where: {$0.plantID == self.userInfo.wantList[indexPath.row]})
                plantViewModel.addGardenPlant(plant!, self.userInfo)
                plantViewModel.removeWantPlant(indexPath.row, self.userInfo)
                collectionView.reloadData()
                
            }
            let removeButton = UIAlertAction(title: "Remover", style: .default) { (UIAlertAction) in
                plantViewModel.removeWantPlant(indexPath.row, self.userInfo)
                collectionView.reloadData()
                print(self.userInfo.wantList.count)
            }

            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            }
            alert.addAction(plantInfoButton)
            alert.addAction(plantButton)
            alert.addAction(removeButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true)
        }else if collectionView == self.harvestCollection{
            self.plantSelected = self.userInfo.planted[indexPath.row]
            self.performSegue(withIdentifier: "plantIdentifier", sender: self)
        }
    }
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.wantCollection.frame.height, height: self.wantCollection.frame.height)
    }
}
