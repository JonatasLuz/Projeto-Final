//
//  PlantedPlant.swift
//  Projeto Final
//
//  Created by Guest User on 23/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
class PlantedPlant{
    var plantId : String!
    var plantedDate : String!
    var harvestMinLimit : String!
    var harvestMaxLimit : String!
    var documentId : String!
    
    init (_ plantId: String, _ plantedDate : String, _ harvestMinLimit : String, _ harvestMaxLimit : String, _ documentId : String ){
        self.plantId = plantId
        self.documentId = documentId
        self.plantedDate = plantedDate
        self.harvestMinLimit = harvestMinLimit
        self.harvestMaxLimit = harvestMaxLimit
    }
}
