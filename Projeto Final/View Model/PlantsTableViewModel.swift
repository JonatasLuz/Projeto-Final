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
    
    func getPlantImageURL(_ url : String) -> UIImage?{
        do{
            let imageURL = try Data(contentsOf: URL.init(string: url)!)
            return UIImage(data: imageURL)
        }catch{
            print("Erro ao buscar imagem de planta \(error)")
        }
        return nil
    }
    
    func getPlants(completion: @escaping ([Plant]) -> Void){
        var plantsArray = [Plant]()
        db.collection("planta").getDocuments { (querySnapShot, error) in
            if let error = error{
                print(error)
                return
            }else{
                for document in querySnapShot!.documents{
                    let eita = Plant(document.data())
                    
                    
                    let plantID = document.documentID
                    let name = document.get("name") as! String
                    let photo = document.get("photo") as! String
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
                    let plant = Plant(plantID, name, photo, information, climate, soil, light, planting, watering, harvest, harvestMinLimit, harvestMaxLimit, plantingMinMonth, plantingMaxMonth)
                    plantsArray.append(plant)
                    
                }
                completion(plantsArray)
            }
        }
    }
}
