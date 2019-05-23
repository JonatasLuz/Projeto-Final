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
    
    func addWantPlant(_ plantId: String, user : User){
        user.wantList.append(plantId)
        let data : [String : Any] = ["want" : user.wantList]
        db.document(user.userId).setData(data)
        print("puta merda")

        
    }
}
