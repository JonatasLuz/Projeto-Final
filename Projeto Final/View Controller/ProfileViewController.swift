//
//  ProfileViewController.swift
//  Projeto Final
//
//  Created by Guest User on 13/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit


let profileCell = "profileCell"
class ProfileViewController: UIViewController {
    @IBOutlet weak var harvestCollection: UICollectionView!
    @IBOutlet weak var profileName: UILabel!
    var userInfo : User!
    @IBOutlet weak var myGardenButton: UIButton!
 
    
    override func viewDidLoad() {
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
        return userInfo.wantList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCell, for: indexPath)
        return cell
    }
}
extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: harvestCollection.frame.height, height: harvestCollection.frame.height)
    }
}
