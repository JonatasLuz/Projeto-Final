//
//  Achievement.swift
//  Projeto Final
//
//  Created by ALUNO on 24/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import UIKit
class Achievement{
    var achievementId : String!
    var name : String!
    var photo : UIImage!
    var description: String!
    var plantList : [String]!
    
    init(){}
    
    init(_ achievementId : String,_ name : String, _ photo : UIImage, _ description: String, _ plantList: [String]){
        self.achievementId = achievementId
        self.name = name
        self.photo = photo
        self.description = description
        self.plantList = plantList
    }
}
