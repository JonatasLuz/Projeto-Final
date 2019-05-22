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
    @IBOutlet weak var myGardenButton: UIButton!
 
    
    override func viewDidLoad() {
        print(userInfo.firstName)
        
        
        profileNameLabel.text = userInfo.firstName
        
        myGardenButton.layer.cornerRadius = 0.5 * myGardenButton.bounds.size.height
        myGardenButton.layer.borderWidth = 1
        myGardenButton.layer.borderColor = UIColor.black.cgColor
        myGardenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myGardenButton.clipsToBounds = true
                print(userInfo.wantList.count)
                super.viewDidLoad()
    }
    
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userInfo.planted.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.harvestCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "harvestCell", for: indexPath)
            return cell
        }else if collectionView == self.wantCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wantCell", for: indexPath)
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
