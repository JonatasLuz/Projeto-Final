//
//  Tool.swift
//  Projeto Final
//
//  Created by Guest User on 26/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import UIKit

class Tool{
    
    let name : String!
    let photo : UIImage!
    let description : String!
    
    init(){
        name = String()
        photo = UIImage()
        description = String()
    }
    
    init(_ name : String, _ photo : UIImage, _ description : String){
        self.name = name
        self.photo = photo
        self.description = description
    }
    
    
}
