//
//  plantViewModel.swift
//  Projeto Final
//
//  Created by Guest User on 16/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import UIKit

class PlantViewModel{
    
    init() {
        
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
}
