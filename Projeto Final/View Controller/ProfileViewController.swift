//
//  ProfileViewController.swift
//  Projeto Final
//
//  Created by Guest User on 13/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit


let plantIdentifier = "profileCell"
class ProfileViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var wantCollection: UICollectionView!
    @IBOutlet weak var harvestCollection: UICollectionView!
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
 
        
        profilePicture.layer.borderWidth = 2
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        profilePicture.clipsToBounds = true

        
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

extension ProfileViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == harvestCollection{
            return 1
        }else if collectionView == wantCollection{
            return 2
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: plantIdentifier, for: indexPath)
        return cell
    }
}
