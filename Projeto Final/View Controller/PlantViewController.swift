//
//  PlantViewController.swift
//  Projeto Final
//
//  Created by ALUNO on 26/04/2019.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class PlantViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var plantImageWC: NSLayoutConstraint!
    @IBOutlet weak var plantImageHC: NSLayoutConstraint!
    
   
    @IBOutlet weak var plantImage: UIImageView!

    @IBOutlet weak var plantImageLeading: NSLayoutConstraint!
    @IBOutlet weak var plantName: UILabel!
    
    
    @IBOutlet weak var plantView: UIView!
    @IBOutlet weak var plantViewHC : NSLayoutConstraint!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        plantViewHC.constant = self.mainView.bounds.height / 2.5
        print(plantViewHC.constant)
        
        plantImageHC.constant = plantViewHC.constant * 0.8
        plantImageWC.constant = plantViewHC.constant * 0.8
        plantImageLeading.constant = (self.mainView.bounds.width - plantImageWC.constant) / 2
        
        plantImage.layer.cornerRadius = plantImageHC.constant/2
        plantImage.clipsToBounds = true
        
        plantName.centerXAnchor.constraint(equalToSystemSpacingAfter: plantImage.centerXAnchor, multiplier: 1).isActive = true
        
        
        
        
        
      
        
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
