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
    var name : String!
    var photo : UIImage!
    var description: String!
    var plantList : [String]!
    
    init(){}
    
    init(_ name : String, _ photo : UIImage, _ description: String, plantList: [String]){
        self.name = name
        self.photo = photo
        self.description = description
        self.plantList = plantList
    }
}
