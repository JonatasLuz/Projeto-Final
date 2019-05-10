//
//  Plant.swift
//  Projeto Final
//
//  Created by ALUNO on 10/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation

class Plant{
    private var name : String!
    private var photo : URL!
    private var information : String!
    private var climate : String!
    private var light : String!
    private var planting : String!
    private var harvest : String!
    private var startMonth : [Int : String]!
    private var endMonth : [Int : String]!
    private var harvestMinLimit : Int!
    private var harvestMaxLimit : Int!
    
    
    
    init(){
        startMonth = [1 : "Janeiro",
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
        endMonth = startMonth
    }
}
