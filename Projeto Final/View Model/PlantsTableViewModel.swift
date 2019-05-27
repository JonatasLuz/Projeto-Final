//
//  PlantsTableViewModel.swift
//  Projeto Final
//
//  Created by Guest User on 14/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
class PlantsTableViewModel{
    
    let db = Firestore.firestore()
    
    init(){
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    func getImage(_ url : String, completion: @escaping (UIImage) -> Void) {
        do{
            let imageURL = try Data(contentsOf: URL.init(string: url)!)
            
            completion(UIImage(data: imageURL)!)
        }catch{
            print("Erro ao buscar imagem de planta \(error)")
        }
    }
    
    
    func getPlants(completion: @escaping ([Plant]) -> Void){
        var plantsArray = [Plant]()
        db.collection("planta").getDocuments { (querySnapShot, error) in
            if let error = error{
                print(error)
                return
            }else{
                for document in querySnapShot!.documents{
                    let plantID = document.documentID
                    let name = document.get("name") as! String
                    let photoURL = document.get("photo") as! String
                    self.getImage(photoURL, completion: { (image) in
                        let information = document.get("information") as! String
                        let climate = document.get("climate") as! String
                        let soil = document.get("soil") as! String
                        let light = document.get("light") as! String
                        let planting = document.get("planting") as! String
                        let watering = document.get("watering") as! String
                        let harvest = document.get("harvest") as! String
                        let harvestMinLimit = document.get("harvestMinLimit") as! Int
                        let harvestMaxLimit = document.get("harvestMaxLimit") as! Int
                        let plantingMaxMonth = document.get("plantingMaxMonth") as! [Int]
                        let plantingMinMonth = document.get("plantingMinMonth") as! [Int]
                        let plant = Plant(plantID, name, image, information, climate, soil, light, planting, watering, harvest, harvestMinLimit, harvestMaxLimit, plantingMinMonth, plantingMaxMonth)
                        plantsArray.append(plant)
                    })
                }
                plantsArray.sort(by: {$0.name < $1.name})
                completion(plantsArray)
            }
        }
    }
    
    func getAchievements(completion: @escaping([Achievement]) -> Void){
        var achvArray = [Achievement]()
        db.collection("conquista").getDocuments { (querySnapShot, error) in
            if let error = error{
                
                print("Error:\(error)")
                return
            }else{
                
                for document in querySnapShot!.documents{
                    let name = document.get("name") as! String
                    let photoUrl = document.get("photo") as! String
                    let description = document.get("description") as! String
                    var plantList = [String]()
                    if document.get("plantList") != nil{
                        plantList = document.get("plantList") as! [String]
                    }
                    self.getImage(photoUrl, completion: { (UIImage) in
                        let achievement = Achievement(document.documentID ,name, UIImage, description, plantList)
                        achvArray.append(achievement)
                    })
                }
                completion(achvArray)
            }
        }
    }
}
