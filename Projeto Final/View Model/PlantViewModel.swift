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
}
