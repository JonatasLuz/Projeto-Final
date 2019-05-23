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
    var userInfo : User!
    
  
    @IBOutlet var superView: UIView!
     @IBOutlet weak var plantViewHC: NSLayoutConstraint!
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var plantImageWC: NSLayoutConstraint!
    @IBOutlet weak var plantImageHC: NSLayoutConstraint!
    
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
    
    @IBOutlet weak var addGarden: UIButton!
    @IBOutlet weak var wantPlantButton: UIButton!
    
    override func viewDidLoad() {
        
        plantViewModel = PlantViewModel()
        
       plantImageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        plantImageHC.constant = superView.bounds.height/3 - (plantName.bounds.height + 20)
        plantImageWC.constant = plantImageHC.constant
        self.view.layoutIfNeeded()
        plantImageView.layer.borderWidth = 8
        plantImageView.layer.borderColor = plantName.textColor.cgColor
        plantImageView.layer.cornerRadius = plantImageHC.constant/2
        plantImageView.layer.masksToBounds = true
        plantImageWC.constant = plantImageHC.constant
        addGarden.layer.cornerRadius = 0.5 * addGarden.bounds.size.height
        wantPlantButton.layer.cornerRadius = 0.5 * wantPlantButton.bounds.size.height
        
        super.viewDidLoad()
        
 
    }
    override func viewWillAppear(_ animated: Bool) {
        let plant = plants[plantSelected]
        
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
        
        //Information View
        informationTextViewHC.constant = self.informationTextView.contentSize.height
        informationViewHC.constant = self.informationTextView.contentSize.height + 30
        
        //Soil View
        soilTextViewHC.constant = self.soilTextView.contentSize.height
        soilViewHC.constant = self.soilTextView.contentSize.height + 30
        
        
        //Climate View
        climateTextViewHC.constant = self.climateTextView.contentSize.height
        climateViewHC.constant = self.climateTextView.contentSize.height + 30
        
        //Light View
        lightTextHC.constant = self.lightTextView.contentSize.height
        lightViewHC.constant = self.lightTextView.contentSize.height + 30
        
        //Plantation View
        plantationTextViewHC.constant = self.plantationTextView.contentSize.height
        plantationViewHC.constant = self.plantationTextView.contentSize.height + 30
        
        //Irrigation View
        irrigationTextViewHC.constant = self.irrigationTextView.contentSize.height
        irrigationViewHC.constant = self.irrigationTextView.contentSize.height + 30
        
        //Harvest View
        harvestTextViewHC.constant = self.harvestTextView.contentSize.height
        harvestViewHC.constant = self.harvestTextView.contentSize.height + 30
        
    }
    
    @IBAction func addAction(_ sender: UIButton) {
    }
    
    @IBAction func wantAction(_ sender: Any) {
        let addPlant = plantViewModel.addWantPlant(plants[plantSelected].plantID, user: userInfo)
        let message : String!
        if addPlant == true{
            message = "Planta adicionada a sua lista."
        }else{
            message = "Voce ja possui a planta na sua lista"
        }
        let alertController = UIAlertController(title: "Quero Plantar", message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        
        }
        alertController.addAction(actionButton)
        self.present(alertController, animated: true)
        
        
    }
    
    
}
