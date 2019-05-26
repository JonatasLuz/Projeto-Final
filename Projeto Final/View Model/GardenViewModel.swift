//
//  GardenViewModel.swift
//  Projeto Final
//
//  Created by ALUNO on 24/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation

class GardenViewModel{
    func checkMinHarvestDate(_ harvestMinDate : String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let currentDate = Date()
        var harvestMin = dateFormatter.date(from: harvestMinDate)
        harvestMin = Calendar.current.date(byAdding: .day, value: -10, to: harvestMin!)
        if currentDate < harvestMin!{
            return false
        }else{
            return true
        }
    }
}
