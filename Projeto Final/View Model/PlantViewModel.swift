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
    var user : User!
    var achievements : [Achievement]!
    init() {
        
    }
    
    func setAchievements(achievements: [Achievement]){
        self.achievements = achievements
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
        //if user doesnt have the achievement, it includes on User my achievements
        let startGardener = user.myAchievements.first(where: {$0 == "gMKLeCFgV11rWKd5bsUz"})
        if startGardener == nil{
            user.myAchievements.append("gMKLeCFgV11rWKd5bsUz")
            let myGardenList = ["myAchievements":user.myAchievements]
            db.document(user.userId).updateData(myGardenList as[AnyHashable : Any])
        }
        //if user doesnt have the achievement, it includes on User my achievements
        let intermediaryGardener = user.myAchievements.first(where: {$0 == "tndmhvGdF8aD8sGzAM55"})
        if intermediaryGardener == nil && (user.myGarden.count + user.planted.count) >= 4{
            user.myAchievements.append("tndmhvGdF8aD8sGzAM55")
            let myGardenList = ["myAchievements" : user.myAchievements]
            db.document(user.userId).updateData(myGardenList as [AnyHashable : Any])
        }
        let advancedGardener = user.myAchievements.first(where: {$0 == "CIhRg1ebt6FJvx1SY6Oe"})
        if advancedGardener == nil && (user.myGarden.count + user.planted.count) >= 14{
            user.myAchievements.append("CIhRg1ebt6FJvx1SY6Oe")
            let myGardenList = ["myGarden": user.myAchievements]
            db.document(user.userId).updateData(myGardenList as [AnyHashable : Any])
        }

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
    
    func harvestPlant(_ index : Int, _ user : User){
        self.user = user
        let plantedPlant = user.myGarden[index]
        if user.planted.firstIndex(of: plantedPlant.plantId) == nil{
            addToPlantedPlant(plantedPlant.plantId)
        }
    }
    
    func addToPlantedPlant(_ plantId : String){
        user.planted.append(plantId)
        let plantedList=["planted":user.planted]
        db.document(user.userId).updateData(plantedList as [AnyHashable : Any])
    }
    
    func getCalendarText(_ minMonth : Int, _ maxMonth : Int) -> String{
        let plant = Plant()
        
        if minMonth == 1 && maxMonth == 12{
            return("Ano Todo")
            
            
        }
        if minMonth == 13 || maxMonth == 13{
            return("*")
            
        }
        if plant.months[minMonth] != nil {
            if plant.months[maxMonth] != nil{
                return("\(plant.months[minMonth]!) até \(plant.months[maxMonth]!)")
            }
        }
        return ""
    }
}
