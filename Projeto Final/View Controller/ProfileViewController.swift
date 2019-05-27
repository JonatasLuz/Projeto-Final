//
//  ProfileViewController.swift
//  Projeto Final
//
//  Created by Guest User on 13/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController  {
    
    @IBOutlet weak var wantCollection: UICollectionView!
    @IBOutlet weak var harvestCollection: UICollectionView!
    @IBOutlet weak var achievementCollection: UICollectionView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    var userInfo : User!
    var plants : [Plant]!
    var achievements: [Achievement]!
    var plantSelected : String!
    
    override func viewDidLoad() {
            profileNameLabel.text = userInfo.firstName
        harvestCollection.layer.borderWidth = 5
        harvestCollection.layer.borderColor = profileNameLabel.textColor.cgColor
        harvestCollection.layer.cornerRadius = harvestCollection.frame.height / 8
        
        wantCollection.layer.borderWidth = 5
        wantCollection.layer.borderColor = profileNameLabel.textColor.cgColor
        wantCollection.layer.cornerRadius = wantCollection.frame.height / 8
        
        achievementCollection.layer.borderWidth = 5
        achievementCollection.layer.borderColor = profileNameLabel.textColor.cgColor
        achievementCollection.layer.cornerRadius = achievementCollection.frame.height / 8
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.reloadInputViews()
        self.harvestCollection.reloadData()
        self.wantCollection.reloadData()
        view.updateConstraintsIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gardenIdentifier"{
            let next = segue.destination as! GardenCollectionViewController
            next.plants = plants
            next.user = userInfo
            next.achievements = achievements
        }
        if segue.identifier == "plantIdentifier"{
            let next = segue.destination as! PlantViewController
            next.plantSelected = plants.firstIndex(where: {$0.plantID == plantSelected})
            next.plants = plants
            next.userInfo = userInfo
            next.achievements = achievements
        }
        if segue.identifier == "menuIdentifier"{
            
            if let navView = segue.destination as? UISideMenuNavigationController{
                let next = navView.topViewController as! MenuTableViewController
                next.plants = plants
                next.user = userInfo
                next.achievements = achievements
            }
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
            cell.plantImageView.layer.borderColor = cell.plantNameLabel.textColor.cgColor
            return cell
        }else if collectionView == self.wantCollection{
            let plant = plants.first(where: {$0.plantID == self.userInfo.wantList[indexPath.row]})
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wantCell", for: indexPath) as! WantCollectionViewCell
            cell.plantImageView.image = plant?.photo
            cell.plantNameLabel.text = plant?.name
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementCollectionViewCell
            let achievement = achievements.first(where: {$0.achievementId == self.userInfo.myAchievements[indexPath.row]})
            cell.achievementImage.image = achievement?.photo
            cell.nameAchievementLabel.text = achievement?.name
            cell.nameAchievementLabel.adjustsFontSizeToFitWidth = true
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
                self.achievementCollection.reloadData()
                self.reloadInputViews()
            }
            let removeButton = UIAlertAction(title: "Remover", style: .destructive) { (UIAlertAction) in
                plantViewModel.removeWantPlant(indexPath.row, self.userInfo)
                collectionView.reloadData()
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
        }else if collectionView == achievementCollection{
            let achievementId = self.userInfo.myAchievements[indexPath.row]
            let achievementSelected = achievements.first(where:{$0.achievementId == achievementId})
            let alert = UIAlertController(title: "Conquista", message: achievementSelected?.description, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in}
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == achievementCollection{
            return CGSize(width: self.wantCollection.frame.height - 5, height: self.wantCollection.frame.height - 10)
        }
         return CGSize(width: view.frame.height/5, height: view.frame.height/5)
    }
}
