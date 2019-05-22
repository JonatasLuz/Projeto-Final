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
    
    @IBOutlet weak var myGardenButton: UIButton!
 
    
    override func viewDidLoad() {
        print(userInfo.firstName)
        
        print(plants.count)
        profileNameLabel.text = userInfo.firstName
        
        myGardenButton.layer.cornerRadius = 0.5 * myGardenButton.bounds.size.height
        myGardenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myGardenButton.clipsToBounds = true
                print(userInfo.wantList.count)
                super.viewDidLoad()
    }
}

extension ProfileViewController : UICollectionViewDataSource{
    
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
            print(cell.plantImageView.frame.height)
            print(cell.plantImageView.frame.width)
            
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
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.wantCollection.frame.height, height: self.wantCollection    .frame.height)
    }
}
