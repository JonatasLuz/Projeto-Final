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
    
    func removeWantPlant(_ index : Int, _ user : User){
        user.wantList.remove(at: index)
        let wantList=["want":user.wantList]
        db.document(user.userId).updateData(wantList as [AnyHashable : Any])
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
        let document = db.document(user.userId).collection("myGarden").document()
        let newPlant = PlantedPlant(plant.plantID, plantedDateString, harvestMinLimitString, harvestMaxLimitString, document.documentID)
        user.myGarden.append(newPlant)
        document.setData(plantedPlant)
    }
    
    func removeGardenPlant(_ index: Int, _ user: User){
        
        let plant = user.myGarden[index]
        let index = user.myGarden.firstIndex(where: {$0.plantId == plant.plantId})
        let documentId = user.myGarden![index!].documentId
        user.myGarden.remove(at: index!)
        db.document(user.userId).collection("myGarden").document(documentId!).delete()
    }
}
