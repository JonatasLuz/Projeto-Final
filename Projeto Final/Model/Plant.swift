//
//  Plant.swift
//  Projeto Final
//
//  Created by ALUNO on 10/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
class Plant{
    var plantID: String!
    var name : String!
    var photo : String!
    var information : String!
    var climate : String!
    var light : String!
    var planting : String!
    var watering : String!
    var harvest : String!
    var harvestMinLimit : Int!
    var harvestMaxLimit : Int!
    var months : [Int : String]!
    var plantingMinMonth : [Int]!
    var plantingMaxMonth : [Int]!
    
    
    
    
    
    init(_ plantID: String, _ name : String, _ photo : String, _ information : String, _ climate : String, _ light : String, _ planting : String, _ watering : String, _ harvest : String, _ harvestMinLimit : Int, _ harvestMaxLimit : Int, _ plantingMinMonth : [Int], _ plantingMaxMonth : [Int]){
        self.plantID = plantID
        self.name = name
        self.photo = photo
        self.information = information
        self.climate = climate
        self.light = light
        self.planting = planting
        self.watering = watering
        self.harvest = harvest
        self.harvestMinLimit = harvestMinLimit
        self.harvestMaxLimit = harvestMaxLimit
        self.plantingMaxMonth = plantingMaxMonth
        self.plantingMinMonth = plantingMinMonth
        self.months = [1 : "Janeiro",
                       2 : "Fevereiro",
                       3 : "Março",
                       4 : "Abril",
                       5 : "Maio",
                       6 : "Junho",
                       7 : "Julho",
                       8 : "Agosto",
                       9 : "Setembro",
                       10 : "Outubro",
                       11 : "Novembro",
                       12: "Dezembro"]
    }
    
    init(){
        
    }
}
