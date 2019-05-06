//
//  PlantViewController.swift
//  Projeto Final
//
//  Created by ALUNO on 03/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class PlantViewController: UIViewController {
   
  
    @IBOutlet var superView: UIView!
    
 
    @IBOutlet weak var plantViewHC: NSLayoutConstraint!
    

    @IBOutlet weak var plantImageView: UIImageView!

    
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationStackView: UIStackView!
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var informationViewHC: NSLayoutConstraint!
    @IBOutlet weak var informationTextViewHC: NSLayoutConstraint!
    
    

    
    override func viewDidLoad() {
        
        plantViewHC.constant = superView.bounds.height / 3
        //plantImageWC.constant = self.plantImageView.bounds.height
        
        
        
        plantImageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: 1).isActive = true
        plantImageView.widthAnchor.constraint(equalTo: plantImageView.heightAnchor, multiplier: 0.5).isActive = true
        
        //let imageHC = self.plantImageView.bounds
        //plantImageWC.constant = imageHC.height * 2
        

        
        
        //Information View
        informationTextViewHC.constant = self.informationTextView.contentSize.height
        informationViewHC.constant = informationViewHC.constant + self.informationTextView.contentSize.height - 25
        
        
    
        
        
        // Do any additional setup after loading the view.
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
