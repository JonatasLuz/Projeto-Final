//
//  PlantViewController.swift
//  Projeto Final
//
//  Created by ALUNO on 03/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class PlantViewController: UIViewController {
    
    var plantSelected : Int!
    var plants: [Plant]!
    var plantViewModel : PlantViewModel!
  
    @IBOutlet var superView: UIView!
 
    @IBOutlet weak var plantViewHC: NSLayoutConstraint!
    @IBOutlet weak var plantImageView: UIImageView!
    
    @IBOutlet weak var plantName: UILabel!
    
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
    
    @IBOutlet weak var plantationTextViewHC: NSLayoutConstraint!
    @IBOutlet weak var plantationTextView: UITextView!
    @IBOutlet weak var plantationViewHC: NSLayoutConstraint!
    
    @IBOutlet weak var irrigationTextViewHC: NSLayoutConstraint!
    @IBOutlet weak var irrigationViewHC: NSLayoutConstraint!
    @IBOutlet weak var irrigationTextView: UITextView!
    
    @IBOutlet weak var harvestTextViewHC: NSLayoutConstraint!
    @IBOutlet weak var harvestViewHC: NSLayoutConstraint!
    @IBOutlet weak var harvestTextView: UITextView!
    
    
    override func viewDidLoad() {
        
 
    }
    override func viewWillAppear(_ animated: Bool) {
        let plant = plants[plantSelected]
        
        plantViewModel = PlantViewModel()
        plantName.text = plant.name
        informationTextView.text = plant.information
        soilTextView.text = plant.soil
        climateTextView.text = plant.climate
        lightTextView.text = plant.light
        plantationTextView.text = plant.planting
        irrigationTextView.text = plant.watering
        harvestTextView.text = plant.harvest
        plantImageView.image = plant.photo
        
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
        soilTextViewHC.constant = self.soilTextView.contentSize.height
        soilViewHC.constant = self.soilTextView.contentSize.height + 25
        
        
        //Climate View
        climateTextViewHC.constant = self.climateTextView.contentSize.height
        climateViewHC.constant = self.climateTextView.contentSize.height + 25
        
        //Light View
        lightTextHC.constant = self.lightTextView.contentSize.height
        lightViewHC.constant = self.lightTextView.contentSize.height + 25
        
        //Plantation View
        plantationTextViewHC.constant = self.plantationTextView.contentSize.height
        plantationViewHC.constant = self.plantationTextView.contentSize.height + 25
        
        //Irrigation View
        irrigationTextViewHC.constant = self.irrigationTextView.contentSize.height
        irrigationViewHC.constant = self.irrigationTextView.contentSize.height + 25
        
        //Harvest View
        harvestTextViewHC.constant = self.harvestTextView.contentSize.height
        harvestViewHC.constant = self.harvestTextView.contentSize.height + 25
        
    }
}
