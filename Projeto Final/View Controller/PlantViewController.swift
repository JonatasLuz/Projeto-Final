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

    
  
    

    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var informationViewHC: NSLayoutConstraint!
    @IBOutlet weak var informationTextViewHC: NSLayoutConstraint!
    
    

    @IBOutlet weak var soilTextView: UITextView!
    @IBOutlet weak var soilTextViewHC: NSLayoutConstraint!
    @IBOutlet weak var soilViewHC: NSLayoutConstraint!
    
    @IBOutlet weak var climateViewHC: NSLayoutConstraint!
    @IBOutlet weak var climateTextView: UITextView!
    @IBOutlet weak var climateTextViewHC: NSLayoutConstraint!
    
   
    @IBOutlet weak var lightViewHC: NSLayoutConstraint!
    @IBOutlet weak var lightTextView: UITextView!
    @IBOutlet weak var lightTextHC: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        
        plantViewHC.constant = superView.bounds.height / 3
        //plantImageWC.constant = self.plantImageView.bounds.height
        
        
        
        plantImageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: 1).isActive = true
        plantImageView.widthAnchor.constraint(equalTo: plantImageView.heightAnchor, multiplier: 0.5).isActive = true
        
        //let imageHC = self.plantImageView.bounds
        //plantImageWC.constant = imageHC.height * 2
        
        //Information View
        informationTextViewHC.constant = self.informationTextView.contentSize.height
        informationViewHC.constant = self.informationTextView.contentSize.height + 25
        
        //Soil View
        soilTextViewHC.constant = self.informationTextView.contentSize.height
        soilViewHC.constant = self.soilTextView.contentSize.height + 25
        
        
        //Climate View
        climateTextViewHC.constant = self.climateTextView.contentSize.height
        climateViewHC.constant = self.climateTextView.contentSize.height + 25
        
        //Light View
        lightTextHC.constant = self.lightTextView.contentSize.height
        lightViewHC.constant = self.lightTextView.contentSize.height + 25
       
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
