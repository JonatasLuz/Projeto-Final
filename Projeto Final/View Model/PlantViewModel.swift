//
//  plantViewModel.swift
//  Projeto Final
//
//  Created by Guest User on 16/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
class PlantViewModel{
    
    let db = Firestore.firestore().collection("usuario")
    
    init() {
        
    }
    
    func addWantPlant(_ plantId: String, user : User) -> Bool{
        
        if user.wantList.first(where: {$0 == plantId}) != nil{
            return false
        }else{
            user.wantList.append(plantId)
            let wantList=["want":user.wantList]
            db.document(user.userId).updateData(wantList as [AnyHashable : Any])
            return true
        }
    }
    
    func addGardenPlant(_ plant: Plant, _ user: User){
        let plantedDate = Date()
        let harvestMinLimit = Calendar.current.date(byAdding: .day, value: plant.harvestMinLimit, to: Date())
        let harvestMaxLimit = Calendar.current.date(byAdding: .day, value: plant.harvestMaxLimit, to: Date())
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let plantedDateString = format.string(from: plantedDate)
        let harvestMinLimitString = format.string(from: harvestMinLimit!)
        let harvestMaxLimitString = format.string(from: harvestMaxLimit!)
        let plantedPlant : [String : Any] = [
            "plantId" : plant.plantID, "plantedDate" : plantedDateString, "harvestMinLimit" : harvestMinLimitString, "harvestMaxLimit" : harvestMaxLimitString
         ]
        let newPlant = PlantedPlant(plant.plantID, plantedDateString, harvestMinLimitString, harvestMaxLimitString)
        user.myGarden.append(newPlant)
        let myGardenRef = db.document(user.userId).collection("myGarden").document().setData(plantedPlant)
        
    }
}
