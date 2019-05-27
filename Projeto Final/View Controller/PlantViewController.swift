//
//  PlantViewController.swift
//  Projeto Final
//
//  Created by ALUNO on 03/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit
import SideMenu

class PlantViewController: UIViewController {
    
    var plantSelected : Int!
    var plants: [Plant]!
    var plantViewModel : PlantViewModel!
    var userInfo : User!
    var achievements: [Achievement]!
    
  
    @IBOutlet weak var southLabel: UILabel!
    @IBOutlet weak var southEastLabel: UILabel!
    @IBOutlet weak var westLabel: UILabel!
    @IBOutlet weak var middleEastLabel: UILabel!
    @IBOutlet weak var northLabel: UILabel!
    @IBOutlet weak var harvestLabel: UILabel!
    
    
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
    
    
    @IBOutlet weak var Label: UILabel!
    
    
    
    override func viewDidLoad() {
        
        plantViewModel = PlantViewModel()
        southLabel.adjustsFontSizeToFitWidth = true
        southEastLabel.adjustsFontSizeToFitWidth = true
        westLabel.adjustsFontSizeToFitWidth = true
        middleEastLabel.adjustsFontSizeToFitWidth = true
        northLabel.adjustsFontSizeToFitWidth = true
        harvestLabel.adjustsFontSizeToFitWidth = true
        Label.adjustsFontSizeToFitWidth = true
       plantImageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        plantImageHC.constant = superView.bounds.height/3 - (plantName.bounds.height + 20)
        plantImageWC.constant = plantImageHC.constant
        self.view.layoutIfNeeded()
        plantImageView.layer.borderWidth = 8
        plantImageView.layer.borderColor = plantName.textColor.cgColor
        plantImageView.layer.cornerRadius = plantImageHC.constant/2
        plantImageView.layer.masksToBounds = true
        plantImageWC.constant = plantImageHC.constant
        addGarden.layer.cornerRadius = addGarden.bounds.size.height / 2.5
        addGarden.titleLabel?.adjustsFontSizeToFitWidth = true
        wantPlantButton.layer.cornerRadius = wantPlantButton.bounds.size.height / 2.5
        wantPlantButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        
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
        
        southLabel.text = plantViewModel.getCalendarText(plant.plantingMinMonth[0], plant.plantingMaxMonth[0])
        southEastLabel.text = plantViewModel.getCalendarText(plant.plantingMinMonth[1], plant.plantingMaxMonth[1])
        southEastLabel.text = plantViewModel.getCalendarText(plant.plantingMinMonth[1], plant.plantingMaxMonth[1])
        westLabel.text = plantViewModel.getCalendarText(plant.plantingMinMonth[2], plant.plantingMaxMonth[2])
        middleEastLabel.text = plantViewModel.getCalendarText(plant.plantingMinMonth[3], plant.plantingMaxMonth[3])
        northLabel.text = plantViewModel.getCalendarText(plant.plantingMinMonth[4], plant.plantingMaxMonth[4])
        harvestLabel.text = ("\(plant.harvestMinLimit!) até \(plant.harvestMaxLimit!) dias")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plantsIdentifier"{
            let next = segue.destination as! PlantsTableViewController
            next.achievements = achievements
            next.plants = plants
            next.user = userInfo
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
    
    @IBAction func addAction(_ sender: UIButton) {
        let addPlant = plantViewModel.addGardenPlant(plants[plantSelected], userInfo)
        let alertController = UIAlertController(title: "Plantar", message: "Planta adicionada a sua horta", preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
        alertController.addAction(actionButton)
        self.present(alertController, animated: true)
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
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
        alertController.addAction(actionButton)
        self.present(alertController, animated: true)
    }
}
